import path from 'node:path';
import { Injectable } from '@nestjs/common';
import { StreamableHTTPServerTransport } from '@modelcontextprotocol/sdk/server/streamableHttp.js';
import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import { z } from 'zod';
import { extractRolesObj, NcApiVersion, ProjectRoles } from 'social-pixl-sdk';
import type { NcContext, NcRequest, UserType } from 'social-pixl-sdk';
import type { Request, Response } from 'express';
import type {
  DataDeleteRequest,
  DataInsertRequest,
  DataUpdateRequest,
} from '~/services/v3/data-v3.types';
import { getPathFromUrl } from '~/helpers/attachmentHelpers';
import { BasesV3Service } from '~/services/v3/bases-v3.service';
import { TablesV3Service } from '~/services/v3/tables-v3.service';
import { DataV3Service } from '~/services/v3/data-v3.service';
import { DataTableService } from '~/services/data-table.service';
import { ColumnsV3Service } from '~/services/v3/columns-v3.service';
import { ViewsService } from '~/services/views.service';
import { KanbansService } from '~/services/kanbans.service';
import { GridsService } from '~/services/grids.service';
import { HooksService } from '~/services/v3/hooks-v3.service';
import { BaseMembersV3Service } from '~/services/v3/base-members-v3.service';
import { CommentsV3Service } from '~/services/v3/comments-v3.service';
import { hasMinimumRole } from '~/utils/roleHelper';
import NcPluginMgrv2 from '~/helpers/NcPluginMgrv2';
import { serialize } from '~/helpers/serialize';
import { AuditsService } from '~/services/audits.service';
import { isEE } from '~/utils';
import { aggregationDescription, whereDescription } from '~/mcp/descriptions';

@Injectable()
export class McpService {
  constructor(
    protected readonly baseV3Service: BasesV3Service,
    protected readonly tablesV3Service: TablesV3Service,
    protected readonly datasV3Service: DataV3Service,
    protected readonly dataTableService: DataTableService,
    protected readonly auditService: AuditsService,
    protected readonly columnsV3Service: ColumnsV3Service,
    protected readonly viewsService: ViewsService,
    protected readonly kanbansService: KanbansService,
    protected readonly gridsService: GridsService,
    protected readonly hooksService: HooksService,
    protected readonly baseMembersV3Service: BaseMembersV3Service,
    protected readonly commentsV3Service: CommentsV3Service,
  ) {}

  async handleRequest(
    tokenId: string,
    context: NcContext,
    req: NcRequest,
    res: Response,
  ) {
    const server = new McpServer({
      name: `NoocDB MCP Server`,
      version: '1.0.0',
    });

    await this.registerTools({ context, user: req.user, server, req });

    const transport = new StreamableHTTPServerTransport({
      sessionIdGenerator: undefined,
    });

    res.on('close', () => {
      transport.close();
      server.close();
    });
    await server.connect(transport);
    await transport.handleRequest(req as Request, res, req.body);
  }

  protected async registerTools({
    server,
    context,
    user,
    req,
  }: {
    context: NcContext;
    user: UserType & {
      base_roles?: Record<string, boolean>;
      workspace_roles?: Record<string, boolean>;
    };
    server: McpServer;
    req: NcRequest;
  }) {
    const isEditorPlus = hasMinimumRole(user, ProjectRoles.EDITOR);

    // Base Details
    server.registerTool(
      'getBaseInfo',
      {
        title: 'Get Base Info',
        description: 'Fetch information about current base',
        annotations: {
          readOnlyHint: true,
          idempotentHint: true,
        },
      }, // No parameters needed
      async () => {
        try {
          const baseInfo = await this.baseV3Service.getProject(context, {
            baseId: context.base_id,
          });

          return {
            content: [
              { type: 'text', text: JSON.stringify(baseInfo, null, 2) },
            ],
          };
        } catch (error) {
          return {
            content: [{ type: 'text', text: `Error: ${error.message}` }],
            isError: true,
          };
        }
      },
    );

    // List Tables
    server.registerTool(
      'getTablesList',
      {
        title: 'List Tables',
        annotations: {
          readOnlyHint: true,
          idempotentHint: true,
        },
        description: 'List tables accessible by user',
      },
      async () => {
        try {
          const tables = await this.tablesV3Service.getAccessibleTables(
            context,
            {
              baseId: context.base_id,
              roles: extractRolesObj(user?.base_roles),
              user,
              allSources: true,
            },
          );

          return {
            content: [{ type: 'text', text: JSON.stringify(tables, null, 2) }],
          };
        } catch (error) {
          return {
            content: [{ type: 'text', text: `Error: ${error.message}` }],
            isError: true,
          };
        }
      },
    );

    // Get Table Schema
    server.registerTool(
      'getTableSchema',
      {
        title: 'Get the table schema',
        description:
          'Get the table schema including fields and views information',
        inputSchema: {
          tableId: z.string().describe('Table Id'),
        },
        annotations: {
          readOnlyHint: true,
          idempotentHint: true,
        },
      },
      async ({ tableId }) => {
        try {
          const table = await this.tablesV3Service.getTableWithAccessibleViews(
            context,
            {
              tableId,
              user,
            },
          );

          if (!table) {
            return {
              content: [
                { type: 'text', text: `Error: Table "${tableId}" not found` },
              ],
              isError: true,
            };
          }
          return {
            content: [{ type: 'text', text: JSON.stringify(table, null, 2) }],
          };
        } catch (error) {
          return {
            content: [{ type: 'text', text: `Error: ${error.message}` }],
            isError: true,
          };
        }
      },
    );

    // Query Records
    server.registerTool(
      'queryRecords',
      {
        title: 'Query Records',
        description: 'Query Records from a Table',
        inputSchema: {
          tableId: z.string().describe('Table ID'),
          pageSize: z
            .number()
            .optional()
            .describe('Number of records to fetch (default: 50)'),
          page: z
            .number()
            .optional()
            .describe('Page number for pagination (default: 1)'),
          where: z.string().optional().describe(whereDescription),
          sort: z
            .array(
              z.object({
                field: z.string().describe('Field Name'),
                description: z.enum(['asc', 'desc']).describe('Sort Direction'),
              }),
            )
            .optional(),
          fields: z
            .array(z.string())
            .optional()
            .describe('Fields to fetch')
            .optional(),
        },
        annotations: {
          readOnlyHint: true,
        },
      },
      async ({ tableId, pageSize = 50, page = 1, where, sort, fields }) => {
        try {
          pageSize = Math.max(1, Math.min(pageSize || 25, 200));
          // Prepare parameters
          const params: any = { pageSize, page };
          if (where) params.where = where;
          if (sort) params.sort = sort;
          if (fields) params.fields = fields;

          const records = await this.datasV3Service.dataList(context, {
            baseId: context.base_id,
            modelId: tableId,
            query: params,
            req: req,
          });

          return {
            content: [{ type: 'text', text: JSON.stringify(records, null, 2) }],
          };
        } catch (error) {
          return {
            content: [{ type: 'text', text: `Error: ${error.message}` }],
            isError: true,
          };
        }
      },
    );

    // Get Record by ID tool
    server.registerTool(
      'getRecord',
      {
        title: 'Get Record',
        description: 'Fetch a record by ID',
        inputSchema: {
          tableId: z.string().describe('Table ID'),
          recordId: z.string().describe('Record ID or primary key value'),
          fields: z
            .string()
            .optional()
            .describe('Comma-separated list of fields to include'),
        },
        annotations: {
          readOnlyHint: true,
        },
      },
      async ({ tableId, recordId, fields }) => {
        try {
          const params: any = {};
          if (fields) params.fields = fields;

          const record = await this.dataTableService.dataRead(context, {
            modelId: tableId,
            rowId: recordId,
            baseId: context.base_id,
            apiVersion: NcApiVersion.V3,
            query: params,
          });

          return {
            content: [{ type: 'text', text: JSON.stringify(record, null, 2) }],
          };
        } catch (error) {
          return {
            content: [{ type: 'text', text: `Error: ${error.message}` }],
            isError: true,
          };
        }
      },
    );

    server.registerTool(
      'countRecords',
      {
        title: 'Count Records',
        description: 'Count Records in a Table',
        inputSchema: {
          tableId: z.string().describe('Table ID'),
          where: z.string().optional().describe(whereDescription),
        },
        annotations: {
          readOnlyHint: true,
        },
      },
      async ({ tableId, where }) => {
        try {
          const params: any = {};
          if (where) params.where = where;

          const count = await this.dataTableService.dataCount(context, {
            baseId: context.base_id,
            modelId: tableId,
            query: params,
            apiVersion: NcApiVersion.V3,
          });

          return {
            content: [{ type: 'text', text: JSON.stringify(count, null, 2) }],
          };
        } catch (error) {
          return {
            content: [{ type: 'text', text: `Error: ${error.message}` }],
            isError: true,
          };
        }
      },
    );

    server.registerTool(
      'readAttachment',
      {
        title: 'Read Attachments',
        description: 'Read attachments in a record',
        inputSchema: {
          files: z
            .array(
              z
                .object({
                  title: z.string().nullable().describe('Attachment title'),
                  mimeType: z
                    .string()
                    .nullable()
                    .describe('Attachment mime type'),
                  size: z.number().nullable().describe('Attachment size'),
                })
                .and(
                  z.union([
                    z.object({
                      url: z
                        .string()
                        .nullable()
                        .describe(
                          'Attachment URL. Required if `path` is not provided.',
                        ),
                      signedUrl: z
                        .string()
                        .nullable()
                        .describe(
                          'Attachment signed URL. Required if `path` is not provided.',
                        ),
                      path: z.null(),
                      signedPath: z.null(),
                    }),
                    z.object({
                      path: z
                        .string()
                        .nullable()
                        .describe(
                          'Attachment path. Required if `url` is not provided.',
                        ),
                      signedPath: z
                        .string()
                        .nullable()
                        .describe(
                          'Attachment signed Path. Required if `url` is not provided.',
                        ),
                      url: z.null(),
                      signedUrl: z.null(),
                    }),
                  ]),
                ),
            )
            .describe('Array of attachment objects from NocoDB'),
        },
        annotations: {
          readOnlyHint: true,
        },
      },
      async ({ files }) => {
        try {
          if (!files || files.length === 0) {
            return {
              content: [
                { type: 'text', text: 'Error: No attachments provided' },
              ],
              isError: true,
            };
          }

          const storageAdapter = await NcPluginMgrv2.storageAdapter();

          const results = await Promise.all(
            files.map(async (file) => {
              try {
                let relativePath;

                // Determine the relative path from attachment
                if (file.path) {
                  relativePath = path.join(
                    'nc',
                    'uploads',
                    file.path.replace(/^download[/\\]/i, ''),
                  );
                } else if (file.url) {
                  relativePath = getPathFromUrl(file.url).replace(/^\/+/, '');
                } else {
                  return {
                    title: file.title || 'Unknown file',
                    error: 'No path or URL available for this attachment',
                  };
                }

                const stream = await storageAdapter.fileReadByStream(
                  relativePath,
                );
                if (!stream) {
                  return {
                    title: file.title || 'Unknown file',
                    error: 'Failed to read file stream',
                  };
                }

                const mimeType = file.mimeType || 'application/octet-stream';

                const serialized = await serialize(
                  mimeType,
                  stream,
                  `Could not process file: ${file.title || 'Unknown file'}`,
                );

                const hasContent =
                  serialized.text && serialized.text !== '@file_not_supported';

                return {
                  title: file.title || 'Unknown file',
                  mimeType,
                  size: file.size,
                  content: hasContent ? serialized.text : null,
                  images: serialized.images,
                  error: hasContent
                    ? null
                    : 'Could not extract text from this file type',
                };
              } catch (error) {
                return {
                  title: file.title || 'Unknown file',
                  error: `Error processing file: ${error.message}`,
                };
              }
            }),
          );

          // Compile all content into one response
          const successfulResults = results.filter((r) => r.content);
          const failedResults = results.filter((r) => r.error);

          // Format content for the response
          let responseText = '';

          if (successfulResults.length > 0) {
            responseText += '## Successfully Processed Files\n\n';

            for (const result of successfulResults) {
              responseText += `### ${result.title}\n`;
              responseText += `**Type:** ${result.mimeType}\n`;
              responseText += `**Size:** ${formatFileSize(result.size)}\n\n`;
              responseText += `${result.content}\n\n`;

              if (result.images && result.images.length > 0) {
                responseText += `*This file contains ${result.images.length} images that cannot be directly displayed in text format.*\n\n`;
              }
            }
          }

          if (failedResults.length > 0) {
            responseText += '## Files With Processing Issues\n\n';

            for (const result of failedResults) {
              responseText += `### ${result.title}\n`;
              responseText += `**Error:** ${result.error}\n\n`;
            }
          }

          return {
            content: [{ type: 'text', text: responseText.trim() }],
          };
        } catch (error) {
          return {
            content: [{ type: 'text', text: `Error: ${error.message}` }],
            isError: true,
          };
        }
      },
    );

    if (!isEE) {
      server.registerTool(
        'aggregate_single',
        {
          title: 'Aggregate',
          description:
            'Perform aggregations on a table with a filter condition',
          annotations: {
            readOnlyHint: true,
            idempotentHint: true,
          },
          inputSchema: {
            tableId: z.string().describe('Table ID'),
            aggregations: z
              .array(
                z.object({
                  field: z.string().describe('Field/column ID to aggregate'),
                  type: z
                    .enum([
                      // Numerical aggregations
                      'sum',
                      'min',
                      'max',
                      'avg',
                      'median',
                      'std_dev',
                      'range',
                      // Common aggregations
                      'count',
                      'count_empty',
                      'count_filled',
                      'count_unique',
                      'percent_empty',
                      'percent_filled',
                      'percent_unique',
                      // Boolean aggregations
                      'checked',
                      'unchecked',
                      'percent_checked',
                      'percent_unchecked',
                      // Date aggregations
                      'earliest_date',
                      'latest_date',
                      'date_range',
                      'month_range',
                      // None
                      'none',
                    ])
                    .describe(aggregationDescription),
                }),
              )
              .describe('Array of aggregations to perform'),
            where: z.string().optional().describe(whereDescription),
            viewId: z
              .string()
              .optional()
              .describe('Optional view ID to use view-specific configurations'),
          },
        },
        async ({ aggregations, tableId, where, viewId }) => {
          try {
            const result = await this.dataTableService.dataAggregate(context, {
              modelId: tableId,
              viewId: viewId,
              query: {
                where: where,
                aggregation: JSON.stringify(aggregations),
              },
            });

            return {
              content: [
                {
                  type: 'text',
                  text: JSON.stringify(result, null, 2),
                },
              ],
              isError: false,
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );
    }

    if (isEditorPlus) {
      // Create Records tool
      server.registerTool(
        'createRecords',
        {
          title: 'Create Records',
          description: 'Create records in a table',
          annotations: {
            readOnlyHint: true,
            idempotentHint: true,
          },
          inputSchema: {
            tableId: z.string().describe('Table ID'),
            records: z
              .array(
                z.object({
                  fields: z.record(
                    z.string().describe('Field name/title'),
                    z.any().describe('Field value'),
                  ),
                }),
              )
              .describe('Array of records with fields as key-value pairs'),
          },
        },
        async ({ tableId, records }) => {
          try {
            const recordsArray = Array.isArray(records) ? records : [records];

            const result = await this.datasV3Service.dataInsert(context, {
              modelId: tableId,
              baseId: context.base_id,
              body: recordsArray as DataInsertRequest[],
              cookie: req,
            });

            return {
              content: [
                { type: 'text', text: JSON.stringify(result, null, 2) },
              ],
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );

      // Update Records tool
      server.registerTool(
        'updateRecords',
        {
          title: 'Update Records',
          description: 'Update records in a table',
          inputSchema: {
            tableId: z.string().describe('Table ID'),
            records: z
              .array(
                z.object({
                  id: z.union([z.string(), z.number()]).describe('Record ID'),
                  fields: z.record(
                    z.string().describe('Field name/title'),
                    z.any().describe('Field value'),
                  ),
                }),
              )
              .describe('Array of records with ID and fields to update'),
          },
          annotations: {
            destructiveHint: true,
          },
        },
        async ({ tableId, records }) => {
          try {
            const recordsArray = Array.isArray(records) ? records : [records];

            const result = await this.datasV3Service.dataUpdate(context, {
              modelId: tableId,
              baseId: context.base_id,
              body: recordsArray as DataUpdateRequest[],
              cookie: req,
            });

            return {
              content: [
                { type: 'text', text: JSON.stringify(result, null, 2) },
              ],
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );

      // Delete Records tool
      server.registerTool(
        'deleteRecords',
        {
          title: 'Delete Records',
          description: 'Delete records in a table',
          annotations: {
            destructiveHint: true,
          },
          inputSchema: {
            tableId: z.string().describe('Table ID'),
            records: z
              .array(
                z.object({
                  id: z.union([z.string(), z.number()]).describe('Record ID'),
                }),
              )
              .describe('Array of records with IDs to delete'),
          },
        },
        async ({ tableId, records }) => {
          try {
            const recordsArray = Array.isArray(records) ? records : [records];
            const result = await this.datasV3Service.dataDelete(context, {
              modelId: tableId,
              baseId: context.base_id,
              body: recordsArray as DataDeleteRequest[],
              cookie: req,
            });

            return {
              content: [
                { type: 'text', text: JSON.stringify(result, null, 2) },
              ],
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );

      // --- Column Management Tools ---

      // Add Column
      server.registerTool(
        'columnAdd',
        {
          title: 'Add Column',
          description: 'Add a new column to a table',
          inputSchema: {
            tableId: z.string().describe('Table ID'),
            column: z
              .object({
                title: z.string().describe('Column title'),
                type: z.string().describe('Column type (UIDT)'),
                column_name: z.string().optional().describe('Database column name'),
                help: z.string().optional().describe('Help text'),
                pv: z.boolean().optional().describe('Is primary value'),
                rqd: z.boolean().optional().describe('Is required'),
                unq: z.boolean().optional().describe('Is unique'),
                ai: z.boolean().optional().describe('Is auto increment'),
                cdf: z.any().optional().describe('Default value'),
                meta: z.any().optional().describe('Column metadata'),
              })
              .describe('Column definition object'),
          },
        },
        async ({ tableId, column }) => {
          try {
            const result = await this.columnsV3Service.columnAdd(context, {
              req,
              tableId,
              column: column as any,
              user,
            });

            return {
              content: [
                { type: 'text', text: JSON.stringify(result, null, 2) },
              ],
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );

      // Update Column
      server.registerTool(
        'columnUpdate',
        {
          title: 'Update Column',
          description: 'Update an existing column definition',
          inputSchema: {
            columnId: z.string().describe('Column ID'),
            column: z
              .object({
                title: z.string().optional().describe('Column title'),
                type: z.string().optional().describe('Column type (UIDT)'),
                column_name: z.string().optional().describe('Database column name'),
                help: z.string().optional().describe('Help text'),
                pv: z.boolean().optional().describe('Is primary value'),
                rqd: z.boolean().optional().describe('Is required'),
                unq: z.boolean().optional().describe('Is unique'),
                ai: z.boolean().optional().describe('Is auto increment'),
                cdf: z.any().optional().describe('Default value'),
                meta: z.any().optional().describe('Column metadata'),
              })
              .describe('Updated column definition'),
          },
        },
        async ({ columnId, column }) => {
          try {
            const result = await this.columnsV3Service.columnUpdate(context, {
              req,
              columnId,
              column: column as any,
              user,
            });

            return {
              content: [
                { type: 'text', text: JSON.stringify(result, null, 2) },
              ],
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );

      // Delete Column
      server.registerTool(
        'columnDelete',
        {
          title: 'Delete Column',
          description: 'Delete a column from a table',
          annotations: {
            destructiveHint: true,
          },
          inputSchema: {
            columnId: z.string().describe('Column ID'),
          },
        },
        async ({ columnId }) => {
          try {
            const result = await this.columnsV3Service.columnDelete(context, {
              req,
              columnId,
              user,
            });

            return {
              content: [
                { type: 'text', text: JSON.stringify(result, null, 2) },
              ],
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );

      // --- View Management Tools ---

      // List Views
      server.registerTool(
        'viewList',
        {
          title: 'List Views',
          description: 'List all views for a table',
          inputSchema: {
            tableId: z.string().describe('Table ID'),
          },
        },
        async ({ tableId }) => {
          try {
            const result = await this.viewsService.viewList(context, {
              tableId,
              user: user as any,
            });

            return {
              content: [
                { type: 'text', text: JSON.stringify(result, null, 2) },
              ],
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );

      // Update View
      server.registerTool(
        'viewUpdate',
        {
          title: 'Update View',
          description: 'Update view configuration',
          inputSchema: {
            viewId: z.string().describe('View ID'),
            view: z
              .object({
                title: z.string().optional().describe('View title'),
                type: z.string().optional().describe('View type'),
                is_default: z.boolean().optional().describe('Is default view'),
                lock_type: z.string().optional().describe('Lock type'),
              })
              .describe('Updated view definition'),
          },
        },
        async ({ viewId, view }) => {
          try {
            const result = await this.viewsService.viewUpdate(context, {
              viewId,
              view: view as any,
              user,
              req,
            });

            return {
              content: [
                { type: 'text', text: JSON.stringify(result, null, 2) },
              ],
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );

      // Delete View
      server.registerTool(
        'viewDelete',
        {
          title: 'Delete View',
          description: 'Delete a view',
          annotations: {
            destructiveHint: true,
          },
          inputSchema: {
            viewId: z.string().describe('View ID'),
          },
        },
        async ({ viewId }) => {
          try {
            const result = await this.viewsService.viewDelete(context, {
              viewId,
              user,
              req,
            });

            return {
              content: [
                { type: 'text', text: JSON.stringify(result, null, 2) },
              ],
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );

      // Create View
      server.registerTool(
        'viewCreate',
        {
          title: 'Create View',
          description: 'Create a new view (Grid or Kanban) for a table',
          inputSchema: {
            tableId: z.string().describe('Table ID'),
            title: z.string().describe('View title'),
            type: z
              .enum(['grid', 'kanban'])
              .describe('View type (default: grid)')
              .default('grid'),
            groupingColumnId: z
              .string()
              .optional()
              .describe('Required for Kanban view: ID of the SingleSelect column to group by'),
          },
        },
        async ({ tableId, title, type, groupingColumnId }) => {
          try {
            let result;
            if (type === 'kanban') {
              if (!groupingColumnId) {
                throw new Error('groupingColumnId is required for Kanban view');
              }
              result = await this.kanbansService.kanbanViewCreate(context, {
                tableId,
                kanban: {
                  title,
                  fk_grp_col_id: groupingColumnId,
                } as any,
                user,
                req,
              });
            } else {
              result = await this.gridsService.gridViewCreate(context, {
                tableId,
                grid: {
                  title,
                } as any,
                user,
                req,
              });
            }

            return {
              content: [
                { type: 'text', text: JSON.stringify(result, null, 2) },
              ],
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );

      // --- Collaboration Tools ---

      // List Comments
      server.registerTool(
        'commentList',
        {
          title: 'List Comments',
          description: 'List comments for a row',
          inputSchema: {
            tableId: z.string().describe('Table ID'),
            rowId: z.string().describe('Row ID'),
          },
        },
        async ({ tableId, rowId }) => {
          try {
            const result = await this.commentsV3Service.commentList(context, {
              query: {
                fk_model_id: tableId,
                row_id: rowId,
              },
            });

            return {
              content: [
                { type: 'text', text: JSON.stringify(result, null, 2) },
              ],
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );

      // Add Comment
      server.registerTool(
        'commentAdd',
        {
          title: 'Add Comment',
          description: 'Add a comment to a row',
          inputSchema: {
            tableId: z.string().describe('Table ID'),
            rowId: z.string().describe('Row ID'),
            comment: z.string().describe('Comment text'),
          },
        },
        async ({ tableId, rowId, comment }) => {
          try {
            const result = await this.commentsV3Service.commentRow(context, {
              body: {
                fk_model_id: tableId,
                row_id: rowId,
                comment,
              },
              user,
              req,
            });

            return {
              content: [
                { type: 'text', text: JSON.stringify(result, null, 2) },
              ],
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );

      // List Users/Collaborators
      server.registerTool(
        'userList',
        {
          title: 'List Users',
          description: 'List collaborators in the base',
          inputSchema: {
            mode: z
              .enum(['full', 'viewer'])
              .optional()
              .describe('Mode (default: full)'),
          },
        },
        async ({ mode = 'full' }) => {
          try {
            const result = await this.baseMembersV3Service.userList(context, {
              baseId: context.base_id,
              mode: mode as 'full' | 'viewer',
            });

            return {
              content: [
                { type: 'text', text: JSON.stringify(result, null, 2) },
              ],
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );

      // Invite User
      server.registerTool(
        'userInvite',
        {
          title: 'Invite User',
          description: 'Invite new collaborators to the base',
          inputSchema: {
            invites: z
              .array(
                z.object({
                  email: z.string().optional().describe('User email'),
                  user_id: z.string().optional().describe('User ID'),
                  base_role: z.string().describe('Base role (e.g. owner, creator, editor, commenter, viewer)'),
                }),
              )
              .describe('Array of users to invite'),
          },
        },
        async ({ invites }) => {
          try {
            const result = await this.baseMembersV3Service.userInvite(context, {
              baseId: context.base_id,
              baseMembers: invites as any,
              req,
            });

            return {
              content: [
                { type: 'text', text: JSON.stringify(result, null, 2) },
              ],
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );

      // --- Automation/Hook Management Tools ---

      // List Hooks
      server.registerTool(
        'hookList',
        {
          title: 'List Hooks',
          description: 'List webhooks for a table',
          inputSchema: {
            tableId: z.string().describe('Table ID'),
          },
        },
        async ({ tableId }) => {
          try {
            const result = await this.hooksService.hookList(context, {
              tableId,
            });

            return {
              content: [
                { type: 'text', text: JSON.stringify(result, null, 2) },
              ],
            };
          } catch (error) {
            return {
              content: [{ type: 'text', text: `Error: ${error.message}` }],
              isError: true,
            };
          }
        },
      );
    }
  }
}

function formatFileSize(bytes?: number | null): string {
  if (bytes === undefined || bytes === null) return 'Unknown size';

  if (bytes < 1024) return `${bytes} bytes`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`;
  if (bytes < 1024 * 1024 * 1024)
    return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
  return `${(bytes / (1024 * 1024 * 1024)).toFixed(1)} GB`;
}

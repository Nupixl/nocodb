import { DBErrorExtractor } from './db-error/extractor';
import type { NcContext } from 'social-pixl-sdk';
import type { ClientType } from 'social-pixl-sdk';
export {
  NcBaseError,
  NcBaseErrorv2,
  NcErrorArgs,
  OptionsNotExistsError,
  BadRequestV2 as BadRequest,
  MetaError,
  SsoError,
  NotFound,
  UnprocessableEntity,
  Unauthorized,
  TestConnectionError,
  Forbidden,
  ExternalError,
  ExternalTimeout,
} from 'social-pixl-sdk';
// Import UniqueConstraintViolationError directly from error module
// as it may not be exported from the main SDK index
export { UniqueConstraintViolationError } from 'social-pixl-sdk';
export { AjvError, NcError } from '~/helpers/ncError';

// extract db errors using database error code
export function extractDBError(
  error,
  context?: NcContext & {
    clientType?: ClientType;
  },
): {
  message: string;
  error: string;
  details?: any;
  code?: string;
  httpStatus: number;
} | void {
  return DBErrorExtractor.get().extractDbError(error, context);
}

# Social Pixl Implementation Guide
## Step-by-Step Setup Instructions

**Purpose**: Practical guide to implement the Social Pixl schema in your NocoDB instance  
**Status**: ✅ **Automated Implementation Supported**  
**Prerequisites**: Access to Social Pixl (NocoDB) instance

---

## 🤖 Automated vs. Manual Setup

### 🚀 Recommended: Automated Setup (Agent)
Since the NocoDB MCP has been expanded with schema management tools, **you can now ask the agent to perform this entire implementation guide for you.**

**How to trigger**:
> "I want you to implement Phase 1 of the Social Pixl schema. Use the `social-pixl-implementation-guide.md` as your specification."

The agent will use `columnAdd` and other MCP tools to create all tables and fields programmatically.

### 🎨 Manual Setup (UI)
If you prefer to set things up yourself or need to configure visual elements (like Kanban column colors or specific view filters), follow the detailed steps below.

---

## Current State Reference

Your existing tables:
- **Project** (ID: `mfk971t8h2y1wl8`) - Has: Id, Title
- **Task** (ID: `mj2wedhjln0dhgd`) - Has: Id, Title  
- **Subtask** (ID: `mpp8oinun8mci5s`) - Has: Id, Title

---

## Implementation Phases

### Phase 1: Core Enhancements (Start Here)
**Time**: 30-45 minutes  
**Goal**: Enable basic protocol tracking

---

## PHASE 1 DETAILED STEPS

### Step 1.1: Enhance Projects Table

1. **Open Social Pixl** in your browser
2. Navigate to **Projects** table
3. Click **+ Add Field** button (top right)
4. Add each field below:

#### Field 1: Description
- **Field Name**: Description
- **Field Type**: Long Text
- **Required**: No
- Click **Save**

#### Field 2: Status
- **Field Name**: Status
- **Field Type**: Single Select
- **Options**: 
  - Active (color: green)
  - On Hold (color: yellow)
  - Completed (color: blue)
  - Archived (color: gray)
- **Default**: Active
- Click **Save**

#### Field 3: Priority
- **Field Name**: Priority
- **Field Type**: Single Select
- **Options**:
  - P0 (Critical) (color: red)
  - P1 (High) (color: orange)
  - P2 (Medium) (color: yellow)
  - P3 (Low) (color: green)
- **Default**: P2 (Medium)
- Click **Save**

#### Field 4: Repository Path
- **Field Name**: Repository Path
- **Field Type**: Single Line Text
- Click **Save**

#### Field 5: Repository URL
- **Field Name**: Repository URL
- **Field Type**: URL
- Click **Save**

#### Field 6: Start Date
- **Field Name**: Start Date
- **Field Type**: Date
- Click **Save**

#### Field 7: Target Completion
- **Field Name**: Target Completion
- **Field Type**: Date
- Click **Save**

#### Field 8: Actual Completion
- **Field Name**: Actual Completion
- **Field Type**: Date
- Click **Save**

#### Field 9: Owner
- **Field Name**: Owner
- **Field Type**: Single Line Text
- Click **Save**

#### Field 10: Tech Stack
- **Field Name**: Tech Stack
- **Field Type**: Multi Select
- **Options**: React, Node.js, TypeScript, Python, Vue.js, PostgreSQL, MongoDB, Docker, Nx, Vercel
- (Add more as needed)
- Click **Save**

#### Field 11: Environment Local
- **Field Name**: Environment Local
- **Field Type**: Single Line Text
- **Placeholder**: e.g., "pnpm dev"
- Click **Save**

#### Field 12: Environment Staging
- **Field Name**: Environment Staging
- **Field Type**: URL
- Click **Save**

#### Field 13: Environment Production
- **Field Name**: Environment Production
- **Field Type**: URL
- Click **Save**

#### Field 14: Notes
- **Field Name**: Notes
- **Field Type**: Long Text
- Click **Save**

#### Field 15: Created At
- **Field Name**: Created At
- **Field Type**: DateTime
- **Default**: Now (auto-fill on creation)
- Click **Save**

#### Field 16: Updated At
- **Field Name**: Updated At
- **Field Type**: DateTime
- **Default**: Now (auto-updated)
- Click **Save**

✅ **Projects table enhanced!**

---

### Step 1.2: Create Features Table

1. Click **+ Create Table** button (left sidebar)
2. **Table Name**: Features
3. Click **Create**

Now add fields:

#### Field 1: Feature Name (automatically created as "Title" - rename it)
- Rename "Title" to "Feature Name"
- **Field Type**: Single Line Text
- **Required**: Yes

#### Field 2: Project (Link to Projects)
- **Field Name**: Project
- **Field Type**: Link to Another Record
- **Linked Table**: Projects
- **Link Type**: Many to One (Many features belong to one project)
- Click **Save**

#### Field 3: Description
- **Field Name**: Description
- **Field Type**: Long Text
- Click **Save**

#### Field 4: Status
- **Field Name**: Status
- **Field Type**: Single Select
- **Options**:
  - Planned (gray)
  - In Progress (blue)
  - Blocked (red)
  - Completed (green)
  - Cancelled (dark gray)
- **Default**: Planned
- Click **Save**

#### Field 5: Priority
- **Field Name**: Priority
- **Field Type**: Single Select
- **Options**: P0 (Critical), P1 (High), P2 (Medium), P3 (Low)
- **Default**: P2 (Medium)
- Click **Save**

#### Field 6: Complexity
- **Field Name**: Complexity
- **Field Type**: Single Select
- **Options**: XS, S, M, L, XL
- **Default**: M
- Click **Save**

#### Field 7: Required MCPs
- **Field Name**: Required MCPs
- **Field Type**: Multi Select
- **Options**: Nx, Supabase, Vercel, Railway, Browser, Chrome DevTools, Plaid, DocuSign, Social Pixl
- Click **Save**

#### Field 8: Success Criteria
- **Field Name**: Success Criteria
- **Field Type**: Long Text
- Click **Save**

#### Field 9: Blockers
- **Field Name**: Blockers
- **Field Type**: Long Text
- Click **Save**

#### Field 10: Assigned To
- **Field Name**: Assigned To
- **Field Type**: Single Line Text
- Click **Save**

#### Field 11: Started At
- **Field Name**: Started At
- **Field Type**: DateTime
- Click **Save**

#### Field 12: Completed At
- **Field Name**: Completed At
- **Field Type**: DateTime
- Click **Save**

#### Field 13: Created At
- **Field Name**: Created At
- **Field Type**: DateTime
- **Default**: Now
- Click **Save**

#### Field 14: Updated At
- **Field Name**: Updated At
- **Field Type**: DateTime
- **Default**: Now (auto-update)
- Click **Save**

✅ **Features table created!**

---

### Step 1.3: Enhance Tasks Table

1. Navigate to **Tasks** table (existing)
2. Add fields:

#### Field 1: Feature (Link)
- **Field Name**: Feature
- **Field Type**: Link to Another Record
- **Linked Table**: Features
- **Link Type**: Many to One
- Click **Save**

#### Field 2: Description
- **Field Name**: Description
- **Field Type**: Long Text
- Click **Save**

#### Field 3: Status
- **Field Name**: Status
- **Field Type**: Single Select
- **Options**: Todo, In Progress, Blocked, Review, Done
- **Default**: Todo
- Click **Save**

#### Field 4: Task Type
- **Field Name**: Task Type
- **Field Type**: Single Select
- **Options**: Research, Implementation, Testing, Documentation, Refactor, Bug Fix, Deploy
- Click **Save**

#### Field 5: Priority
- **Field Name**: Priority
- **Field Type**: Number
- **Min**: 1
- **Max**: 5
- **Default**: 3
- Click **Save**

#### Field 6: Estimated Time
- **Field Name**: Estimated Time
- **Field Type**: Single Line Text
- **Placeholder**: e.g., "2 hrs"
- Click **Save**

#### Field 7: Actual Time
- **Field Name**: Actual Time
- **Field Type**: Single Line Text
- Click **Save**

#### Field 8: Required MCPs
- **Field Name**: Required MCPs
- **Field Type**: Multi Select
- **Options**: (Same as Features - Nx, Supabase, Vercel, etc.)
- Click **Save**

#### Field 9: File Paths
- **Field Name**: File Paths
- **Field Type**: Long Text
- **Help Text**: "JSON array of file paths"
- Click **Save**

#### Field 10: Dependencies
- **Field Name**: Dependencies
- **Field Type**: Link to Another Record
- **Linked Table**: Task (same table - self-link)
- **Link Type**: Many to Many
- Click **Save**

#### Field 11: Blockers
- **Field Name**: Blockers
- **Field Type**: Long Text
- Click **Save**

#### Field 12: Completion Promise
- **Field Name**: Completion Promise
- **Field Type**: Single Line Text
- **Placeholder**: e.g., "<promise>TASK_COMPLETE</promise>"
- Click **Save**

#### Field 13: Max Iterations
- **Field Name**: Max Iterations
- **Field Type**: Number
- **Default**: 20
- Click **Save**

#### Field 14: Current Iteration
- **Field Name**: Current Iteration
- **Field Type**: Number
- **Default**: 0
- Click **Save**

#### Field 15: Ralph Status
- **Field Name**: Ralph Status
- **Field Type**: Single Select
- **Options**: Pending, Active, Paused, Complete, Failed, Blocked
- **Default**: Pending
- Click **Save**

#### Field 16: Checklist Total Steps
- **Field Name**: Checklist Total Steps
- **Field Type**: Number
- **Default**: 0
- Click **Save**

#### Field 17: Checklist Completed
- **Field Name**: Checklist Completed
- **Field Type**: Number
- **Default**: 0
- Click **Save**

#### Field 18: Checklist Progress
- **Field Name**: Checklist Progress
- **Field Type**: Percent
- **Formula**: `{Checklist Completed} / {Checklist Total Steps} * 100`
- Click **Save**

#### Field 19: Current Step
- **Field Name**: Current Step
- **Field Type**: Single Line Text
- Click **Save**

#### Field 20: Failure Count
- **Field Name**: Failure Count
- **Field Type**: Number
- **Default**: 0
- Click **Save**

#### Field 21: Last Error
- **Field Name**: Last Error
- **Field Type**: Long Text
- Click **Save**

#### Field 22: Local Log Path
- **Field Name**: Local Log Path
- **Field Type**: Single Line Text
- **Placeholder**: ".agents/feature-name/task-id/"
- Click **Save**

#### Field 23: Agent Notes
- **Field Name**: Agent Notes
- **Field Type**: Long Text
- Click **Save**

#### Field 24: Created At
- **Field Name**: Created At
- **Field Type**: DateTime
- **Default**: Now
- Click **Save**

#### Field 25: Started At
- **Field Name**: Started At
- **Field Type**: DateTime
- Click **Save**

#### Field 26: Completed At
- **Field Name**: Completed At
- **Field Type**: DateTime
- Click **Save**

#### Field 27: Updated At
- **Field Name**: Updated At
- **Field Type**: DateTime
- **Default**: Now (auto-update)
- Click **Save**

✅ **Tasks table enhanced!**

---

### Step 1.4: Create Protocol Sessions Table

1. Click **+ Create Table**
2. **Table Name**: Protocol Sessions
3. Add fields:

#### Auto-created: Id (keep it)

#### Field 1: Session ID
- **Field Name**: Session ID
- **Field Type**: Single Line Text
- **Required**: Yes
- Click **Save**

#### Field 2: Protocol Name
- **Field Name**: Protocol Name
- **Field Type**: Single Select
- **Options**: Ralph, Test, Security, Deploy, Debug, Audit, Performance
- **Required**: Yes
- Click **Save**

#### Field 3: Feature
- **Field Name**: Feature
- **Field Type**: Link to Another Record
- **Linked Table**: Features
- Click **Save**

#### Field 4: Task
- **Field Name**: Task
- **Field Type**: Link to Another Record
- **Linked Table**: Task
- Click **Save**

#### Field 5: Status
- **Field Name**: Status
- **Field Type**: Single Select
- **Options**: Active, Paused, Complete, Terminated, Failed
- **Default**: Active
- Click **Save**

#### Field 6: Invoked By User
- **Field Name**: Invoked By User
- **Field Type**: Long Text
- Click **Save**

#### Field 7: Scope
- **Field Name**: Scope
- **Field Type**: Long Text
- Click **Save**

#### Field 8: Session Log Path
- **Field Name**: Session Log Path
- **Field Type**: Single Line Text
- Click **Save**

#### Field 9: Iterations Used
- **Field Name**: Iterations Used
- **Field Type**: Number
- **Default**: 0
- Click **Save**

#### Field 10: Max Iterations
- **Field Name**: Max Iterations
- **Field Type**: Number
- Click **Save**

#### Field 11: Human Interventions
- **Field Name**: Human Interventions
- **Field Type**: Number
- **Default**: 0
- Click **Save**

#### Field 12: Outcome Summary
- **Field Name**: Outcome Summary
- **Field Type**: Long Text
- Click **Save**

#### Field 13: Started At
- **Field Name**: Started At
- **Field Type**: DateTime
- **Default**: Now
- Click **Save**

#### Field 14: Completed At
- **Field Name**: Completed At
- **Field Type**: DateTime
- Click **Save**

#### Field 15: Duration
- **Field Name**: Duration
- **Field Type**: Duration
- **Formula**: `{Completed At} - {Started At}`
- Click **Save**

✅ **Protocol Sessions table created!**

---

### Step 1.5: Create Human Checkpoints Table

1. Click **+ Create Table**
2. **Table Name**: Human Checkpoints
3. Add fields:

#### Auto-created: Id (keep it)

#### Field 1: Protocol Session
- **Field Name**: Protocol Session
- **Field Type**: Link to Another Record
- **Linked Table**: Protocol Sessions
- **Required**: Yes
- Click **Save**

#### Field 2: Feature
- **Field Name**: Feature
- **Field Type**: Link to Another Record
- **Linked Table**: Features
- Click **Save**

#### Field 3: Task
- **Field Name**: Task
- **Field Type**: Link to Another Record
- **Linked Table**: Task
- Click **Save**

#### Field 4: Checkpoint Type
- **Field Name**: Checkpoint Type
- **Field Type**: Single Select
- **Options**: Plan Approval, Blocker, Max Iterations, Critical Failure, Final Review
- **Required**: Yes
- Click **Save**

#### Field 5: Status
- **Field Name**: Status
- **Field Type**: Single Select
- **Options**: Pending, Approved, Rejected, Modified, Resolved
- **Default**: Pending
- Click **Save**

#### Field 6: Agent Summary
- **Field Name**: Agent Summary
- **Field Type**: Long Text
- Click **Save**

#### Field 7: Proposed Options
- **Field Name**: Proposed Options
- **Field Type**: Long Text
- Click **Save**

#### Field 8: Human Decision
- **Field Name**: Human Decision
- **Field Type**: Long Text
- Click **Save**

#### Field 9: Local File Path
- **Field Name**: Local File Path
- **Field Type**: Single Line Text
- Click **Save**

#### Field 10: Created At
- **Field Name**: Created At
- **Field Type**: DateTime
- **Default**: Now
- Click **Save**

#### Field 11: Resolved At
- **Field Name**: Resolved At
- **Field Type**: DateTime
- Click **Save**

✅ **Human Checkpoints table created!**

---

## ✅ PHASE 1 COMPLETE!

You now have the core structure to support protocol tracking.

**Test it**:
1. Create a sample project in Projects table
2. Create a sample feature linked to that project
3. Create a sample task linked to that feature
4. Verify all links work

---

## PHASE 2: Ralph Protocol Support (Do Next)

### Step 2.1: Create Task Checklists Table

1. Click **+ Create Table**
2. **Table Name**: Task Checklists
3. Add fields:

#### Auto-created: Id

#### Field 1: Task
- **Field Name**: Task
- **Field Type**: Link to Another Record
- **Linked Table**: Task
- **Required**: Yes
- **Link Type**: Many to One
- Click **Save**

#### Field 2: Step Number
- **Field Name**: Step Number
- **Field Type**: Number
- **Required**: Yes
- Click **Save**

#### Field 3: Step Type
- **Field Name**: Step Type
- **Field Type**: Single Select
- **Options**: Prep, Execute, Verify, Deploy, Document
- Click **Save**

#### Field 4: Step Name
- **Field Name**: Step Name
- **Field Type**: Single Line Text
- **Required**: Yes
- Click **Save**

#### Field 5: Status
- **Field Name**: Status
- **Field Type**: Single Select
- **Options**: Pending, In Progress, Done, Failed, Blocked
- **Default**: Pending
- Click **Save**

#### Field 6: Is Preparatory
- **Field Name**: Is Preparatory
- **Field Type**: Checkbox
- **Default**: False
- Click **Save**

#### Field 7: Required for Completion
- **Field Name**: Required for Completion
- **Field Type**: Checkbox
- **Default**: True
- Click **Save**

#### Field 8: Attempts
- **Field Name**: Attempts
- **Field Type**: Number
- **Default**: 0
- Click **Save**

#### Field 9: Last Error
- **Field Name**: Last Error
- **Field Type**: Long Text
- Click **Save**

#### Field 10: Retry Strategy
- **Field Name**: Retry Strategy
- **Field Type**: Long Text
- Click **Save**

#### Field 11: Duration
- **Field Name**: Duration
- **Field Type**: Single Line Text
- Click **Save**

#### Field 12: Created At
- **Field Name**: Created At
- **Field Type**: DateTime
- **Default**: Now
- Click **Save**

#### Field 13: Started At
- **Field Name**: Started At
- **Field Type**: DateTime
- Click **Save**

#### Field 14: Completed At
- **Field Name**: Completed At
- **Field Type**: DateTime
- Click **Save**

✅ **Task Checklists table created!**

---

### Step 2.2: Create Agent Iterations Log Table

1. Click **+ Create Table**
2. **Table Name**: Agent Iterations Log
3. Add fields:

#### Auto-created: Id

#### Field 1: Protocol Session
- **Field Name**: Protocol Session
- **Field Type**: Link to Another Record
- **Linked Table**: Protocol Sessions
- Click **Save**

#### Field 2: Task
- **Field Name**: Task
- **Field Type**: Link to Another Record
- **Linked Table**: Task
- Click **Save**

#### Field 3: Checklist Step
- **Field Name**: Checklist Step
- **Field Type**: Link to Another Record
- **Linked Table**: Task Checklists
- Click **Save**

#### Field 4: Iteration Number
- **Field Name**: Iteration Number
- **Field Type**: Number
- **Required**: Yes
- Click **Save**

#### Field 5: Action
- **Field Name**: Action
- **Field Type**: Single Select
- **Options**: Execute, Verify, Retry, Complete, Block
- Click **Save**

#### Field 6: Result
- **Field Name**: Result
- **Field Type**: Single Select
- **Options**: Success, Failure, Blocked, N/A
- Click **Save**

#### Field 7: Details
- **Field Name**: Details
- **Field Type**: Long Text
- Click **Save**

#### Field 8: Error Message
- **Field Name**: Error Message
- **Field Type**: Long Text
- Click **Save**

#### Field 9: Retry Strategy
- **Field Name**: Retry Strategy
- **Field Type**: Long Text
- Click **Save**

#### Field 10: MCP Calls
- **Field Name**: MCP Calls
- **Field Type**: Long Text
- **Help Text**: "JSON format"
- Click **Save**

#### Field 11: Files Modified
- **Field Name**: Files Modified
- **Field Type**: Long Text
- **Help Text**: "JSON array"
- Click **Save**

#### Field 12: Duration
- **Field Name**: Duration
- **Field Type**: Single Line Text
- Click **Save**

#### Field 13: Timestamp
- **Field Name**: Timestamp
- **Field Type**: DateTime
- **Default**: Now
- Click **Save**

✅ **Agent Iterations Log table created!**

---

### Step 2.3: Add Rollup Fields to Features Table

1. Navigate to **Features** table
2. Add rollup fields:

#### Rollup 1: Tasks Count
- **Field Name**: Tasks Count
- **Field Type**: Rollup
- **Rollup Field**: Count records in Task where Task.Feature = this Feature
- Click **Save**

#### Rollup 2: Tasks Completed
- **Field Name**: Tasks Completed
- **Field Type**: Rollup
- **Rollup Field**: Count records in Task where Task.Feature = this Feature AND Task.Status = "Done"
- Click **Save**

✅ **Phase 2 complete!**

---

## PHASE 3: Optimization (Optional)

### Step 3.1: Create MCP Registry Table

1. Click **+ Create Table**
2. **Table Name**: MCP Registry
3. Add fields following the schema document

### Step 3.2: Enhance Subtasks Table

1. Navigate to Subtasks table
2. Add fields following the schema document

### Step 3.3: Create Custom Views

Follow the views section in the schema document.

---

## Post-Setup: Update Agent Rules

After creating all tables, you need to update the agent rules with actual table IDs:

### Get Table IDs

Run this MCP call:
```javascript
CallMcpTool: user-NocoDB Base - Social Pixl / getTablesList
```

You'll get something like:
```json
[
  {"id": "mfk971t8h2y1wl8", "title": "Project"},
  {"id": "mj2wedhjln0dhgd", "title": "Task"},
  {"id": "mpp8oinun8mci5s", "title": "Subtask"},
  {"id": "new_id_1", "title": "Features"},
  {"id": "new_id_2", "title": "Protocol Sessions"},
  ...
]
```

### Update Rule Files

Create a new file: `.cursor/rules/20-social-pixl-table-ids.mdc`:

```markdown
# Social Pixl Table IDs

Reference for all Social Pixl (NocoDB) table IDs.
Agents use these IDs when calling Social Pixl MCP.

## Table IDs

- **Projects**: `mfk971t8h2y1wl8`
- **Features**: `[new_id_from_getTablesList]`
- **Tasks**: `mj2wedhjln0dhgd`
- **Task Checklists**: `[new_id_from_getTablesList]`
- **Subtasks**: `mpp8oinun8mci5s`
- **Protocol Sessions**: `[new_id_from_getTablesList]`
- **Agent Iterations Log**: `[new_id_from_getTablesList]`
- **Human Checkpoints**: `[new_id_from_getTablesList]`
- **MCP Registry**: `[new_id_from_getTablesList]`

## Usage

When calling Social Pixl MCP, use these IDs:

```javascript
CallMcpTool: user-NocoDB Base - Social Pixl / queryRecords
{
  tableId: "[Table ID from above]",
  where: "...",
  sort: [...]
}
```
```

---

## Testing Your Setup

### Test 1: Create Sample Project

1. Open Projects table
2. Click **+ Add Record**
3. Fill in:
   - Title: "Test Project"
   - Description: "Testing Social Pixl setup"
   - Status: Active
   - Priority: P2 (Medium)
4. Save

### Test 2: Create Sample Feature

1. Open Features table
2. Click **+ Add Record**
3. Fill in:
   - Feature Name: "Test Feature"
   - Project: Link to "Test Project"
   - Status: Planned
   - Priority: P2
4. Save

### Test 3: Create Sample Task

1. Open Tasks table
2. Click **+ Add Record**
3. Fill in:
   - Title: "Test Task"
   - Feature: Link to "Test Feature"
   - Status: Todo
   - Task Type: Implementation
4. Save

### Test 4: Verify Links

1. Go to Projects table
2. Click on "Test Project"
3. You should see linked feature
4. Click on Feature
5. You should see linked task

✅ If all links work, your setup is correct!

---

## Troubleshooting

### Issue: Can't create Link fields
**Solution**: Make sure the target table exists first before creating link

### Issue: Rollup fields not working
**Solution**: Ensure link fields are created first, then add rollups

### Issue: Formula fields show error
**Solution**: Check field names match exactly (case-sensitive)

### Issue: Can't find table ID
**Solution**: Use `getTablesList` MCP call to retrieve IDs

---

## Next Steps

After setup complete:

1. ✅ Populate MCP Registry with your available MCPs
2. ✅ Create your first real project
3. ✅ Test Ralph Protocol with a simple feature
4. ✅ Create dashboard views for monitoring
5. ✅ Train team on Social Pixl workflows

---

## Quick Reference

### Most Used MCP Calls

**List Tables**:
```javascript
CallMcpTool: user-NocoDB Base - Social Pixl / getTablesList
{}
```

**Get Table Schema**:
```javascript
CallMcpTool: user-NocoDB Base - Social Pixl / getTableSchema
{tableId: "table_id_here"}
```

**Query Records**:
```javascript
CallMcpTool: user-NocoDB Base - Social Pixl / queryRecords
{
  tableId: "table_id_here",
  where: "(Status,eq,Active)",
  pageSize: 50
}
```

**Create Record**:
```javascript
CallMcpTool: user-NocoDB Base - Social Pixl / createRecords
{
  tableId: "table_id_here",
  records: [{
    fields: {
      Title: "New Record",
      Status: "Active"
    }
  }]
}
```

**Update Record**:
```javascript
CallMcpTool: user-NocoDB Base - Social Pixl / updateRecords
{
  tableId: "table_id_here",
  records: [{
    id: "record_id_here",
    fields: {
      Status: "Completed"
    }
  }]
}
```

---

**Document Version**: 1.0  
**Created**: 2026-01-18  
**Estimated Setup Time**: 2-3 hours for complete implementation

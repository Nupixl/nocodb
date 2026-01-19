# Social Pixl Schema Design
## Single Source of Truth for Project Management

**Last Updated**: 2026-01-18  
**Status**: Implementation Guide  
**Purpose**: Define comprehensive database schema for Social Pixl (NocoDB) as canonical project management system

---

## Overview

Social Pixl serves as the **single source of truth** for all project management activities, protocol executions, and agent work tracking. This document defines the complete schema needed to support the modular protocol system.

---

## Current State

### Existing Tables
1. **Project** (Table ID: `mfk971t8h2y1wl8`)
   - Fields: Id, Title
   
2. **Task** (Table ID: `mj2wedhjln0dhgd`)
   - Fields: Id, Title
   
3. **Subtask** (Table ID: `mpp8oinun8mci5s`)
   - Fields: Id, Title

---

## Required Schema Enhancements

### Table 1: Projects (Enhance Existing)

**Current Table ID**: `mfk971t8h2y1wl8`

**Fields to Add**:

| Field Name | Type | Options | Purpose |
|------------|------|---------|---------|
| Description | Long Text | - | Detailed project description and goals |
| Status | Single Select | Active, On Hold, Completed, Archived | Current project state |
| Priority | Single Select | P0 (Critical), P1 (High), P2 (Medium), P3 (Low) | Project priority level |
| Repository Path | Single Line Text | - | Path to git repository |
| Repository URL | URL | - | GitHub/GitLab URL |
| Start Date | Date | - | Project start date |
| Target Completion | Date | - | Target completion date |
| Actual Completion | Date | - | When project actually completed |
| Owner | Single Line Text | - | Project owner/lead |
| Tech Stack | Multi Select | React, Node.js, TypeScript, Python, etc. | Technologies used |
| Environment Local | Single Line Text | - | Local dev command (e.g., "pnpm dev") |
| Environment Staging | URL | - | Staging environment URL |
| Environment Production | URL | - | Production environment URL |
| Notes | Long Text | - | General notes and context |
| Created At | Date Time | Auto-filled | Creation timestamp |
| Updated At | Date Time | Auto-updated | Last update timestamp |

---

### Table 2: Features (New Table)

**Purpose**: High-level features within projects

**Fields**:

| Field Name | Type | Options | Purpose |
|------------|------|---------|---------|
| Id | ID | Auto | Primary key |
| Feature Name | Single Line Text | Required | Clear feature name |
| Project | Link to Projects | - | Parent project |
| Description | Long Text | - | Detailed feature requirements |
| Status | Single Select | Planned, In Progress, Blocked, Completed, Cancelled | Current status |
| Priority | Single Select | P0, P1, P2, P3 | Feature priority |
| Complexity | Single Select | XS, S, M, L, XL | Estimated complexity |
| Required MCPs | Multi Select | Nx, Supabase, Vercel, Railway, Browser, Chrome DevTools, Plaid, DocuSign, Social Pixl | MCPs needed for this feature |
| Success Criteria | Long Text | - | How to know when complete |
| Tasks Count | Rollup from Tasks | COUNT | Total tasks |
| Tasks Completed | Rollup from Tasks | COUNT with filter | Completed tasks count |
| Blockers | Long Text | - | Current blockers or issues |
| Assigned To | Single Line Text | - | Who's responsible |
| Started At | Date Time | - | When work began |
| Completed At | Date Time | - | When feature completed |
| Created At | Date Time | Auto | Creation timestamp |
| Updated At | Date Time | Auto | Last update timestamp |

---

### Table 3: Tasks (Enhance Existing)

**Current Table ID**: `mj2wedhjln0dhgd`

**Fields to Add**:

| Field Name | Type | Options | Purpose |
|------------|------|---------|---------|
| Feature | Link to Features | - | Parent feature |
| Description | Long Text | - | Detailed task description |
| Status | Single Select | Todo, In Progress, Blocked, Review, Done | Current status |
| Task Type | Single Select | Research, Implementation, Testing, Documentation, Refactor, Bug Fix, Deploy | Task category |
| Priority | Number | 1-5 | Task priority (1=highest) |
| Estimated Time | Single Line Text | - | e.g., "30 min", "2 hrs" |
| Actual Time | Single Line Text | - | Time actually spent |
| Required MCPs | Multi Select | Same as Features | MCPs needed |
| File Paths | Long Text | JSON format | Files to be modified |
| Dependencies | Link to Tasks | Self-link | Depends on these tasks |
| Blockers | Long Text | - | What's blocking this |
| Completion Promise | Single Line Text | - | e.g., "<promise>AUTH_COMPLETE</promise>" |
| Max Iterations | Number | Default: 20 | Ralph Protocol iteration limit |
| Current Iteration | Number | Default: 0 | Current Ralph iteration |
| Ralph Status | Single Select | Pending, Active, Paused, Complete, Failed, Blocked | Ralph Protocol status |
| Checklist Total Steps | Number | - | Total checklist items |
| Checklist Completed | Number | - | Completed checklist items |
| Checklist Progress | Percent | Formula: Completed/Total | Progress percentage |
| Current Step | Single Line Text | - | Current step being worked |
| Failure Count | Number | Default: 0 | Number of failed attempts |
| Last Error | Long Text | - | Most recent error message |
| Local Log Path | Single Line Text | - | Path to .agents/ folder |
| Agent Notes | Long Text | - | Agent's working notes |
| Created At | Date Time | Auto | Creation timestamp |
| Started At | Date Time | - | When work started |
| Completed At | Date Time | - | When completed |
| Updated At | Date Time | Auto | Last update timestamp |

---

### Table 4: Task Checklists (New Table)

**Purpose**: Step-by-step checklist for each task (used by Ralph Protocol)

**Fields**:

| Field Name | Type | Options | Purpose |
|------------|------|---------|---------|
| Id | ID | Auto | Primary key |
| Task | Link to Tasks | Required | Parent task |
| Step Number | Number | Required | Order of execution (1, 2, 3...) |
| Step Type | Single Select | Prep, Execute, Verify, Deploy, Document | Step category |
| Step Name | Single Line Text | Required | Clear step description |
| Status | Single Select | Pending, In Progress, Done, Failed, Blocked | Current status |
| Is Preparatory | Checkbox | - | True if prep step |
| Required for Completion | Checkbox | Default: true | Must complete to finish task |
| Attempts | Number | Default: 0 | How many times tried |
| Last Error | Long Text | - | Error from latest attempt |
| Retry Strategy | Long Text | - | What to try next |
| Duration | Single Line Text | - | Time taken to complete |
| Created At | Date Time | Auto | Creation timestamp |
| Started At | Date Time | - | When step started |
| Completed At | Date Time | - | When step completed |

---

### Table 5: Protocol Sessions (New Table)

**Purpose**: Track all protocol executions

**Fields**:

| Field Name | Type | Options | Purpose |
|------------|------|---------|---------|
| Id | ID | Auto | Primary key |
| Session ID | Single Line Text | Auto-generated | Unique session identifier |
| Protocol Name | Single Select | Ralph, Test, Security, Deploy, Debug, Audit, Performance | Which protocol |
| Feature | Link to Features | - | Related feature (optional) |
| Task | Link to Tasks | - | Related task (optional) |
| Status | Single Select | Active, Paused, Complete, Terminated, Failed | Session status |
| Invoked By User | Long Text | - | User's exact invocation phrase |
| Scope | Long Text | - | What protocol is working on |
| Session Log Path | Single Line Text | - | Path to .agents/ folder |
| Iterations Used | Number | - | Total iterations executed |
| Max Iterations | Number | - | Maximum allowed |
| Human Interventions | Number | Default: 0 | Number of checkpoints |
| Outcome Summary | Long Text | - | Final results/findings |
| Started At | Date Time | Auto | When protocol started |
| Completed At | Date Time | - | When protocol ended |
| Duration | Duration | Formula | Time taken |

---

### Table 6: Agent Iterations Log (New Table)

**Purpose**: Detailed log of every Ralph Protocol iteration

**Fields**:

| Field Name | Type | Options | Purpose |
|------------|------|---------|---------|
| Id | ID | Auto | Primary key |
| Protocol Session | Link to Protocol Sessions | - | Parent session |
| Task | Link to Tasks | - | Task being worked |
| Checklist Step | Link to Task Checklists | - | Specific step |
| Iteration Number | Number | Required | Which iteration |
| Action | Single Select | Execute, Verify, Retry, Complete, Block | What happened |
| Result | Single Select | Success, Failure, Blocked, N/A | Outcome |
| Details | Long Text | - | What was done |
| Error Message | Long Text | - | Error if any |
| Retry Strategy | Long Text | - | What will be tried next |
| MCP Calls | Long Text | JSON format | MCPs used |
| Files Modified | Long Text | JSON array | Files changed |
| Duration | Single Line Text | - | Time taken |
| Timestamp | Date Time | Auto | When this occurred |

---

### Table 7: Human Checkpoints (New Table)

**Purpose**: Track human approval/intervention points

**Fields**:

| Field Name | Type | Options | Purpose |
|------------|------|---------|---------|
| Id | ID | Auto | Primary key |
| Protocol Session | Link to Protocol Sessions | Required | Related session |
| Feature | Link to Features | - | Related feature (optional) |
| Task | Link to Tasks | - | Related task (optional) |
| Checkpoint Type | Single Select | Plan Approval, Blocker, Max Iterations, Critical Failure, Final Review | Type of checkpoint |
| Status | Single Select | Pending, Approved, Rejected, Modified, Resolved | Current status |
| Agent Summary | Long Text | - | Agent's explanation |
| Proposed Options | Long Text | - | Agent's suggestions |
| Human Decision | Long Text | - | Human's choice/input |
| Local File Path | Single Line Text | - | .agents/ checkpoint file |
| Created At | Date Time | Auto | When requested |
| Resolved At | Date Time | - | When resolved |

---

### Table 8: MCP Registry (New Table)

**Purpose**: Track available MCPs and their status

**Fields**:

| Field Name | Type | Options | Purpose |
|------------|------|---------|---------|
| Id | ID | Auto | Primary key |
| MCP Name | Single Line Text | Required | Display name |
| Server Name | Single Line Text | Required | Actual MCP server ID |
| Category | Single Select | Database, Deployment, Testing, Build, Financial, Documents, Project Management, Browser | MCP type |
| Description | Long Text | - | What this MCP does |
| Capabilities | Multi Select | CRUD, Deploy, Test, Build, Query, Profile, Debug | What it can do |
| Status | Single Select | Enabled, Disabled, Unavailable, Testing | Current status |
| Required By Protocols | Multi Select | Ralph, Test, Security, Deploy, Debug, Audit, Performance | Which protocols need it |
| Used By Protocols | Multi Select | Same as above | Which protocols use it |
| Connection URL | Single Line Text | - | API endpoint if applicable |
| Documentation URL | URL | - | MCP documentation link |
| Notes | Long Text | - | Additional context |
| Last Tested | Date Time | - | Last availability check |
| Created At | Date Time | Auto | When added |
| Updated At | Date Time | Auto | Last update |

---

### Table 9: Subtasks (Enhance Existing)

**Current Table ID**: `mpp8oinun8mci5s`

**Purpose**: Optional granular breakdown below tasks

**Fields to Add**:

| Field Name | Type | Options | Purpose |
|------------|------|---------|---------|
| Task | Link to Tasks | - | Parent task |
| Description | Long Text | - | Subtask details |
| Status | Single Select | Todo, In Progress, Done | Current status |
| Assigned To | Single Line Text | - | Who's responsible |
| Estimated Time | Single Line Text | - | Time estimate |
| Actual Time | Single Line Text | - | Actual duration |
| Created At | Date Time | Auto | Creation timestamp |
| Completed At | Date Time | - | Completion timestamp |

---

## Relationships & Links

### Data Flow
```
Projects (1) → (Many) Features (1) → (Many) Tasks (1) → (Many) Subtasks
                                          ↓
                                   Task Checklists
                                          ↓
Protocol Sessions → Agent Iterations Log → Task Checklists
       ↓
Human Checkpoints
```

### Key Relationships
1. **Project → Features**: One-to-Many (Projects have multiple features)
2. **Feature → Tasks**: One-to-Many (Features have multiple tasks)
3. **Task → Task Checklists**: One-to-Many (Tasks have multiple checklist steps)
4. **Task → Subtasks**: One-to-Many (Tasks can have subtasks)
5. **Task → Tasks**: Many-to-Many (Tasks can depend on other tasks)
6. **Protocol Session → Tasks**: One-to-Many (Session can work on multiple tasks)
7. **Protocol Session → Agent Iterations Log**: One-to-Many (Session has multiple iterations)
8. **Protocol Session → Human Checkpoints**: One-to-Many (Session can have multiple checkpoints)
9. **Task Checklists → Agent Iterations Log**: One-to-Many (Step can have multiple iteration attempts)

---

## Implementation Priority

### Phase 1: Core Enhancements (Do First)
1. ✅ Enhance **Projects** table with additional fields
2. ✅ Enhance **Tasks** table with Ralph Protocol fields
3. ✅ Create **Protocol Sessions** table
4. ✅ Create **Human Checkpoints** table

**Result**: Basic protocol tracking functional

---

### Phase 2: Ralph Protocol Support (Do Second)
1. ✅ Create **Features** table
2. ✅ Create **Task Checklists** table
3. ✅ Create **Agent Iterations Log** table
4. ✅ Link Tasks to Features
5. ✅ Link Checklists to Tasks

**Result**: Full Ralph Protocol support

---

### Phase 3: Optimization (Do Third)
1. ✅ Create **MCP Registry** table
2. ✅ Enhance **Subtasks** table
3. ✅ Add rollup fields for metrics
4. ✅ Create custom views for dashboards

**Result**: Complete project management system

---

## Views to Create

### For Projects Table
1. **Active Projects** - Filter: Status = Active
2. **By Priority** - Sorted by Priority (P0 first)
3. **Completed Projects** - Filter: Status = Completed

### For Features Table
1. **In Progress Features** - Filter: Status = In Progress
2. **Blocked Features** - Filter: Status = Blocked
3. **By Project** - Grouped by Project
4. **Completion Dashboard** - Show progress metrics

### For Tasks Table
1. **My Tasks** - Filter: Assigned To = [current user]
2. **Todo Tasks** - Filter: Status = Todo
3. **Blocked Tasks** - Filter: Status = Blocked
4. **Ralph Active** - Filter: Ralph Status = Active
5. **By Feature** - Grouped by Feature

### For Protocol Sessions Table
1. **Active Protocols** - Filter: Status = Active
2. **Recent Sessions** - Sort by Started At (desc)
3. **By Protocol Type** - Grouped by Protocol Name

### For Human Checkpoints Table
1. **Pending Approvals** - Filter: Status = Pending
2. **Recent Checkpoints** - Sort by Created At (desc)

---

## Sample Data Templates

### Sample Project
```json
{
  "Title": "NocoDB - Social Pixl",
  "Description": "Open source Airtable alternative with enhanced AI features",
  "Status": "Active",
  "Priority": "P0 (Critical)",
  "Repository Path": "/Users/elijahwilliams/Documents/GitHub/nocodb",
  "Repository URL": "https://github.com/nocodb/nocodb",
  "Tech Stack": ["TypeScript", "Node.js", "Vue.js", "PostgreSQL"],
  "Environment Local": "pnpm dev",
  "Owner": "Elijah Williams"
}
```

### Sample Feature
```json
{
  "Feature Name": "User Authentication System",
  "Project": "NocoDB - Social Pixl",
  "Description": "Complete authentication with login, register, password reset, and OAuth",
  "Status": "In Progress",
  "Priority": "P0",
  "Complexity": "L",
  "Required MCPs": ["Supabase", "Nx", "Browser"],
  "Success Criteria": "Users can login, register, reset password, and use Google OAuth"
}
```

### Sample Task
```json
{
  "Title": "Implement JWT Middleware",
  "Feature": "User Authentication System",
  "Description": "Create middleware to validate JWT tokens on protected routes",
  "Status": "In Progress",
  "Task Type": "Implementation",
  "Priority": 1,
  "Estimated Time": "2 hrs",
  "Required MCPs": ["Nx", "Supabase"],
  "Completion Promise": "<promise>JWT_MIDDLEWARE_COMPLETE</promise>",
  "Max Iterations": 20,
  "Ralph Status": "Active"
}
```

### Sample Protocol Session
```json
{
  "Protocol Name": "Ralph",
  "Feature": "User Authentication System",
  "Status": "Active",
  "Invoked By User": "Start Ralph Protocol on authentication feature",
  "Scope": "Complete all authentication tasks including login, register, password reset, and OAuth",
  "Session Log Path": ".agents/ralph-auth-session-001/",
  "Max Iterations": 60
}
```

---

## Query Examples

### Get All Active Tasks for a Feature
```javascript
CallMcpTool: user-NocoDB Base - Social Pixl / queryRecords
{
  tableId: "[Tasks Table ID]",
  where: "(Feature,eq,feature-auth-001)~and(Status,neq,Done)",
  sort: [{ field: "Priority", description: "asc" }]
}
```

### Get Current Active Protocol
```javascript
CallMcpTool: user-NocoDB Base - Social Pixl / queryRecords
{
  tableId: "[Protocol Sessions Table ID]",
  where: "(Status,eq,Active)",
  sort: [{ field: "Started At", description: "desc" }],
  pageSize: 1
}
```

### Get Pending Human Checkpoints
```javascript
CallMcpTool: user-NocoDB Base - Social Pixl / queryRecords
{
  tableId: "[Human Checkpoints Table ID]",
  where: "(Status,eq,Pending)",
  sort: [{ field: "Created At", description: "asc" }]
}
```

### Get Task Progress
```javascript
CallMcpTool: user-NocoDB Base - Social Pixl / queryRecords
{
  tableId: "[Task Checklists Table ID]",
  where: "(Task,eq,task-004)",
  sort: [{ field: "Step Number", description: "asc" }]
}
```

---

## Metrics & Reporting

### Key Metrics to Track

**Project Level**:
- Total features: COUNT(Features)
- Completed features: COUNT(Features WHERE Status = Completed)
- Total tasks: SUM(Features.Tasks Count)
- Completion percentage: (Completed Tasks / Total Tasks) * 100

**Feature Level**:
- Tasks completed: Rollup COUNT
- Average task completion time: AVG(Tasks.Actual Time)
- Blocked tasks: COUNT(Tasks WHERE Status = Blocked)

**Protocol Level**:
- Average iterations per task: AVG(Agent Iterations Log.Iteration Number)
- Success rate: (Completed / Total) * 100
- Average human interventions: AVG(Protocol Sessions.Human Interventions)
- Most used protocol: MODE(Protocol Sessions.Protocol Name)

---

## Dashboard Recommendations

### Executive Dashboard
- Active projects count
- Features in progress
- Tasks completed this week
- Current blockers

### Developer Dashboard
- My assigned tasks
- Tasks ready to start (no dependencies)
- Blocked tasks requiring attention
- Recent protocol executions

### Protocol Dashboard
- Active protocols
- Pending human checkpoints
- Protocol success rates
- MCP availability status

---

## Maintenance

### Regular Updates
- **Weekly**: Review blocked tasks and checkpoints
- **Bi-weekly**: Update MCP Registry status
- **Monthly**: Archive completed projects
- **Quarterly**: Clean up old protocol sessions (keep last 3 months)

### Data Integrity
- Ensure all tasks link to features
- Verify completion promises are set
- Check MCP associations are current
- Validate relationship links

---

## Next Steps

1. **Review this schema** with your team
2. **Implement Phase 1** enhancements in Social Pixl UI
3. **Test protocol workflows** with a sample project
4. **Create views and dashboards** for visibility
5. **Update agent rules** with actual Table IDs after creation
6. **Train team** on using Social Pixl as single source of truth

---

## Notes

- Table IDs are currently placeholders - update after creating tables
- Field types may need adjustment based on NocoDB capabilities
- Custom formulas can be added for calculated fields
- Consider adding webhooks for real-time notifications
- Backup Social Pixl database regularly

---

**Document Version**: 1.0  
**Created**: 2026-01-18  
**Author**: AI Agent  
**Status**: Ready for Implementation

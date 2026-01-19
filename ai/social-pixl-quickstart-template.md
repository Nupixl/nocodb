# Social Pixl Quick Start Template
## Sample Data for Testing Your Setup

**Purpose**: Ready-to-use sample data to test your Social Pixl project management system  
**Use**: Import or manually create these records after Phase 1 setup

---

## Sample Project: NocoDB Development

### Project Record

```json
{
  "Title": "NocoDB - Social Pixl Platform",
  "Description": "Open-source Airtable alternative with AI-powered features and agent protocol system. Building the fastest way to create databases online.",
  "Status": "Active",
  "Priority": "P0 (Critical)",
  "Repository Path": "/Users/elijahwilliams/Documents/GitHub/nocodb",
  "Repository URL": "https://github.com/nocodb/nocodb",
  "Start Date": "2026-01-15",
  "Target Completion": "2026-03-31",
  "Owner": "Elijah Williams",
  "Tech Stack": ["TypeScript", "Node.js", "Vue.js", "PostgreSQL", "Docker", "Nx"],
  "Environment Local": "pnpm dev",
  "Environment Staging": "https://staging.nocodb.com",
  "Environment Production": "https://nocodb.com",
  "Notes": "Focus on AI agent integration and protocol system for Q1 2026"
}
```

---

## Sample Features

### Feature 1: Agent Protocol System

```json
{
  "Feature Name": "Agent Protocol System",
  "Project": "[Link to NocoDB - Social Pixl Platform]",
  "Description": "Implement modular protocol system allowing agents to execute Ralph, Test, Security, Deploy, Debug, and Audit protocols with user control and Social Pixl integration.",
  "Status": "In Progress",
  "Priority": "P0",
  "Complexity": "XL",
  "Required MCPs": ["Social Pixl", "Nx"],
  "Success Criteria": "- User can invoke protocols explicitly\n- Ralph Protocol executes with checklist tracking\n- All activity logged to Social Pixl\n- Human checkpoints functional\n- Documentation complete",
  "Assigned To": "AI Agent",
  "Started At": "2026-01-18T14:00:00Z"
}
```

### Feature 2: User Authentication

```json
{
  "Feature Name": "User Authentication System",
  "Project": "[Link to NocoDB - Social Pixl Platform]",
  "Description": "Complete authentication system with login, registration, password reset, Google OAuth, and JWT token management.",
  "Status": "Planned",
  "Priority": "P0",
  "Complexity": "L",
  "Required MCPs": ["Supabase", "Nx", "Browser"],
  "Success Criteria": "- Users can register and login\n- Password reset via email works\n- Google OAuth functional\n- JWT tokens secure\n- Tests passing with 85%+ coverage",
  "Assigned To": "To Be Assigned"
}
```

### Feature 3: Real-time Collaboration

```json
{
  "Feature Name": "Real-time Collaboration",
  "Project": "[Link to NocoDB - Social Pixl Platform]",
  "Description": "Enable multiple users to edit databases simultaneously with real-time updates, presence indicators, and conflict resolution.",
  "Status": "Planned",
  "Priority": "P1",
  "Complexity": "XL",
  "Required MCPs": ["Supabase", "Vercel", "Nx"],
  "Success Criteria": "- Real-time updates working\n- User presence visible\n- Conflict resolution automatic\n- Performance: <100ms latency\n- Works with 10+ concurrent users"
}
```

---

## Sample Tasks (for Agent Protocol System Feature)

### Task 1: Create Protocol Rule Files

```json
{
  "Title": "Create Protocol Rule Files",
  "Feature": "[Link to Agent Protocol System]",
  "Description": "Create all protocol specification rule files: 09-protocol-system.mdc, 10-ralph-protocol.mdc, 11-test-protocol.mdc, 12-security-protocol.mdc, etc. Each file should follow the template and be self-contained.",
  "Status": "Done",
  "Task Type": "Documentation",
  "Priority": 1,
  "Estimated Time": "3 hrs",
  "Actual Time": "2.5 hrs",
  "Required MCPs": [],
  "Completion Promise": "<promise>PROTOCOL_RULES_COMPLETE</promise>",
  "Max Iterations": 10,
  "Ralph Status": "Complete",
  "Completed At": "2026-01-18T16:30:00Z"
}
```

### Task 2: Design Social Pixl Schema

```json
{
  "Title": "Design Social Pixl Schema for Project Management",
  "Feature": "[Link to Agent Protocol System]",
  "Description": "Design comprehensive database schema for Social Pixl including Projects, Features, Tasks, Task Checklists, Protocol Sessions, Agent Iterations Log, Human Checkpoints, and MCP Registry tables.",
  "Status": "Done",
  "Task Type": "Research",
  "Priority": 1,
  "Estimated Time": "2 hrs",
  "Actual Time": "1.5 hrs",
  "Required MCPs": ["Social Pixl"],
  "Completion Promise": "<promise>SCHEMA_DESIGN_COMPLETE</promise>",
  "Max Iterations": 10,
  "Ralph Status": "Complete",
  "Completed At": "2026-01-18T17:00:00Z"
}
```

### Task 3: Implement Social Pixl Tables (Phase 1)

```json
{
  "Title": "Implement Social Pixl Tables - Phase 1",
  "Feature": "[Link to Agent Protocol System]",
  "Description": "Enhance Projects and Tasks tables, create Features, Protocol Sessions, and Human Checkpoints tables in Social Pixl (NocoDB) following implementation guide.",
  "Status": "Todo",
  "Task Type": "Implementation",
  "Priority": 1,
  "Estimated Time": "1 hr",
  "Required MCPs": ["Social Pixl"],
  "Completion Promise": "<promise>PHASE1_TABLES_COMPLETE</promise>",
  "Max Iterations": 15,
  "Ralph Status": "Pending",
  "Blockers": "Requires manual setup in NocoDB UI by user"
}
```

### Task 4: Implement Ralph Protocol Integration

```json
{
  "Title": "Implement Ralph Protocol Integration with Social Pixl",
  "Feature": "[Link to Agent Protocol System]",
  "Description": "Code the Ralph Protocol logic to create checklists in Social Pixl, log iterations, handle checkpoints, and track progress in real-time. Test with sample feature.",
  "Status": "Todo",
  "Task Type": "Implementation",
  "Priority": 1,
  "Estimated Time": "4 hrs",
  "Required MCPs": ["Social Pixl", "Nx"],
  "File Paths": "[\"packages/nocodb/src/protocols/ralph.ts\", \"packages/nocodb/src/protocols/base-protocol.ts\"]",
  "Dependencies": "[Link to Task 3: Implement Social Pixl Tables]",
  "Completion Promise": "<promise>RALPH_INTEGRATION_COMPLETE</promise>",
  "Max Iterations": 30,
  "Ralph Status": "Pending"
}
```

### Task 5: Create Test Suite for Protocols

```json
{
  "Title": "Create Test Suite for Protocol System",
  "Feature": "[Link to Agent Protocol System]",
  "Description": "Write comprehensive tests for protocol invocation, execution, checkpoints, termination, and resumption. Test Social Pixl integration.",
  "Status": "Todo",
  "Task Type": "Testing",
  "Priority": 2,
  "Estimated Time": "3 hrs",
  "Required MCPs": ["Social Pixl", "Nx"],
  "Dependencies": "[Link to Task 4: Implement Ralph Protocol Integration]",
  "Completion Promise": "<promise>PROTOCOL_TESTS_COMPLETE</promise>",
  "Max Iterations": 20,
  "Ralph Status": "Pending"
}
```

### Task 6: Write Protocol Documentation

```json
{
  "Title": "Write User-Facing Protocol Documentation",
  "Feature": "[Link to Agent Protocol System]",
  "Description": "Create comprehensive user documentation explaining how to invoke protocols, what each protocol does, and how to track progress in Social Pixl.",
  "Status": "Todo",
  "Task Type": "Documentation",
  "Priority": 3,
  "Estimated Time": "2 hrs",
  "Required MCPs": [],
  "Completion Promise": "<promise>PROTOCOL_DOCS_COMPLETE</promise>",
  "Max Iterations": 10,
  "Ralph Status": "Pending"
}
```

---

## Sample Tasks (for User Authentication Feature)

### Task 1: Setup Supabase Auth Configuration

```json
{
  "Title": "Setup Supabase Auth Configuration",
  "Feature": "[Link to User Authentication System]",
  "Description": "Configure Supabase project with auth providers (email, Google OAuth), set callback URLs, configure JWT secrets, and set up SMTP for email.",
  "Status": "Todo",
  "Task Type": "Implementation",
  "Priority": 1,
  "Estimated Time": "1 hr",
  "Required MCPs": ["Supabase"],
  "Completion Promise": "<promise>SUPABASE_AUTH_CONFIG_COMPLETE</promise>",
  "Max Iterations": 15,
  "Ralph Status": "Pending"
}
```

### Task 2: Implement JWT Middleware

```json
{
  "Title": "Implement JWT Middleware",
  "Feature": "[Link to User Authentication System]",
  "Description": "Create Express middleware to validate JWT tokens on protected routes. Middleware should extract token from Authorization header, verify signature, check expiration, and attach user object to request.",
  "Status": "Todo",
  "Task Type": "Implementation",
  "Priority": 1,
  "Estimated Time": "2 hrs",
  "Required MCPs": ["Nx", "Supabase"],
  "File Paths": "[\"packages/nocodb/src/middleware/auth.middleware.ts\"]",
  "Dependencies": "[Link to Task 1: Setup Supabase Auth Configuration]",
  "Completion Promise": "<promise>JWT_MIDDLEWARE_COMPLETE</promise>",
  "Max Iterations": 20,
  "Ralph Status": "Pending"
}
```

### Task 3: Create Auth API Endpoints

```json
{
  "Title": "Create Auth API Endpoints",
  "Feature": "[Link to User Authentication System]",
  "Description": "Implement POST /auth/login, POST /auth/register, POST /auth/logout, POST /auth/refresh-token endpoints with proper validation, error handling, and Supabase integration.",
  "Status": "Todo",
  "Task Type": "Implementation",
  "Priority": 1,
  "Estimated Time": "3 hrs",
  "Required MCPs": ["Nx", "Supabase"],
  "File Paths": "[\"packages/nocodb/src/routes/auth.routes.ts\", \"packages/nocodb/src/controllers/auth.controller.ts\"]",
  "Dependencies": "[Link to Task 2: Implement JWT Middleware]",
  "Completion Promise": "<promise>AUTH_ENDPOINTS_COMPLETE</promise>",
  "Max Iterations": 25,
  "Ralph Status": "Pending"
}
```

### Task 4: Implement Password Reset Flow

```json
{
  "Title": "Implement Password Reset Flow",
  "Feature": "[Link to User Authentication System]",
  "Description": "Create password reset functionality: generate reset token, send email with reset link, validate reset token, allow password change. Include token expiration (24 hours) and one-time use.",
  "Status": "Todo",
  "Task Type": "Implementation",
  "Priority": 2,
  "Estimated Time": "2.5 hrs",
  "Required MCPs": ["Supabase"],
  "File Paths": "[\"packages/nocodb/src/services/auth.service.ts\", \"packages/nocodb/src/templates/password-reset-email.html\"]",
  "Completion Promise": "<promise>PASSWORD_RESET_COMPLETE</promise>",
  "Max Iterations": 20,
  "Ralph Status": "Pending"
}
```

### Task 5: Implement Google OAuth Integration

```json
{
  "Title": "Implement Google OAuth Integration",
  "Feature": "[Link to User Authentication System]",
  "Description": "Integrate Google OAuth: create OAuth client, implement callback route, handle token exchange, create/update user in database, generate JWT for session.",
  "Status": "Todo",
  "Task Type": "Implementation",
  "Priority": 2,
  "Estimated Time": "2 hrs",
  "Required MCPs": ["Supabase", "Browser"],
  "File Paths": "[\"packages/nocodb/src/routes/oauth.routes.ts\"]",
  "Completion Promise": "<promise>OAUTH_GOOGLE_COMPLETE</promise>",
  "Max Iterations": 25,
  "Ralph Status": "Pending"
}
```

### Task 6: Write Auth Tests

```json
{
  "Title": "Write Authentication Tests",
  "Feature": "[Link to User Authentication System]",
  "Description": "Write comprehensive test suite: unit tests for middleware and services, integration tests for auth flows (login, register, password reset, OAuth), E2E tests for complete user journeys. Target: 85%+ coverage.",
  "Status": "Todo",
  "Task Type": "Testing",
  "Priority": 2,
  "Estimated Time": "3 hrs",
  "Required MCPs": ["Nx", "Browser"],
  "Dependencies": "[Link to all auth implementation tasks]",
  "Completion Promise": "<promise>AUTH_TESTS_COMPLETE</promise>",
  "Max Iterations": 25,
  "Ralph Status": "Pending"
}
```

---

## Sample Protocol Session

```json
{
  "Session ID": "ralph-auth-session-001",
  "Protocol Name": "Ralph",
  "Feature": "[Link to User Authentication System]",
  "Status": "Active",
  "Invoked By User": "Start Ralph Protocol on user authentication feature",
  "Scope": "Complete all authentication tasks: Supabase config, JWT middleware, auth endpoints, password reset, Google OAuth, and tests",
  "Session Log Path": ".agents/ralph-auth-session-001/",
  "Max Iterations": 60,
  "Started At": "2026-01-18T18:00:00Z"
}
```

---

## Sample Human Checkpoint

```json
{
  "Protocol Session": "[Link to ralph-auth-session-001]",
  "Feature": "[Link to User Authentication System]",
  "Task": "[Link to Task 4: Implement Password Reset Flow]",
  "Checkpoint Type": "Blocker",
  "Status": "Pending",
  "Agent Summary": "Step 8 of password reset flow blocked: SMTP not configured in Supabase. Cannot send password reset emails. Attempted 3 times with different configurations, all resulting in connection timeout.",
  "Proposed Options": "1. Configure SMTP settings in Supabase dashboard\n2. Use mock email service for testing (can complete task but production needs real SMTP)\n3. Skip password reset for now and move to OAuth task",
  "Local File Path": ".agents/ralph-auth-session-001/task-004/blocker-001.md",
  "Created At": "2026-01-18T19:15:00Z"
}
```

---

## Sample Task Checklists (for JWT Middleware Task)

### Checklist Steps

```json
[
  {
    "Task": "[Link to Task 2: Implement JWT Middleware]",
    "Step Number": 1,
    "Step Type": "Prep",
    "Step Name": "Read existing auth code to understand patterns",
    "Status": "Done",
    "Is Preparatory": true,
    "Required for Completion": true,
    "Attempts": 1,
    "Duration": "45 seconds",
    "Started At": "2026-01-18T18:30:00Z",
    "Completed At": "2026-01-18T18:30:45Z"
  },
  {
    "Task": "[Link to Task 2: Implement JWT Middleware]",
    "Step Number": 2,
    "Step Type": "Prep",
    "Step Name": "Identify dependencies needed (jsonwebtoken, types)",
    "Status": "Done",
    "Is Preparatory": true,
    "Required for Completion": true,
    "Attempts": 1,
    "Duration": "30 seconds",
    "Completed At": "2026-01-18T18:31:15Z"
  },
  {
    "Task": "[Link to Task 2: Implement JWT Middleware]",
    "Step Number": 3,
    "Step Type": "Prep",
    "Step Name": "Review existing test patterns",
    "Status": "Done",
    "Is Preparatory": true,
    "Required for Completion": true,
    "Attempts": 1,
    "Duration": "40 seconds",
    "Completed At": "2026-01-18T18:31:55Z"
  },
  {
    "Task": "[Link to Task 2: Implement JWT Middleware]",
    "Step Number": 4,
    "Step Type": "Execute",
    "Step Name": "Create middleware file and basic structure",
    "Status": "Done",
    "Is Preparatory": false,
    "Required for Completion": true,
    "Attempts": 1,
    "Duration": "60 seconds",
    "Completed At": "2026-01-18T18:32:55Z"
  },
  {
    "Task": "[Link to Task 2: Implement JWT Middleware]",
    "Step Number": 5,
    "Step Type": "Execute",
    "Step Name": "Add JWT token extraction from Authorization header",
    "Status": "Done",
    "Is Preparatory": false,
    "Required for Completion": true,
    "Attempts": 1,
    "Duration": "45 seconds",
    "Completed At": "2026-01-18T18:33:40Z"
  },
  {
    "Task": "[Link to Task 2: Implement JWT Middleware]",
    "Step Number": 6,
    "Step Type": "Execute",
    "Step Name": "Implement token verification logic",
    "Status": "Done",
    "Is Preparatory": false,
    "Required for Completion": true,
    "Attempts": 2,
    "Last Error": "ValidationError: Token format invalid (attempt 1)",
    "Duration": "90 seconds",
    "Completed At": "2026-01-18T18:35:10Z"
  },
  {
    "Task": "[Link to Task 2: Implement JWT Middleware]",
    "Step Number": 7,
    "Step Type": "Execute",
    "Step Name": "Add error handling and status codes",
    "Status": "Done",
    "Is Preparatory": false,
    "Required for Completion": true,
    "Attempts": 1,
    "Duration": "50 seconds",
    "Completed At": "2026-01-18T18:36:00Z"
  },
  {
    "Task": "[Link to Task 2: Implement JWT Middleware]",
    "Step Number": 8,
    "Step Type": "Verify",
    "Step Name": "Write unit tests for middleware",
    "Status": "Done",
    "Is Preparatory": false,
    "Required for Completion": true,
    "Attempts": 1,
    "Duration": "2 minutes",
    "Completed At": "2026-01-18T18:38:00Z"
  },
  {
    "Task": "[Link to Task 2: Implement JWT Middleware]",
    "Step Number": 9,
    "Step Type": "Verify",
    "Step Name": "Run tests and verify passing",
    "Status": "Done",
    "Is Preparatory": false,
    "Required for Completion": true,
    "Attempts": 1,
    "Duration": "30 seconds",
    "Completed At": "2026-01-18T18:38:30Z"
  },
  {
    "Task": "[Link to Task 2: Implement JWT Middleware]",
    "Step Number": 10,
    "Step Type": "Verify",
    "Step Name": "Check code coverage meets threshold",
    "Status": "Done",
    "Is Preparatory": false,
    "Required for Completion": true,
    "Attempts": 1,
    "Duration": "20 seconds",
    "Completed At": "2026-01-18T18:38:50Z"
  },
  {
    "Task": "[Link to Task 2: Implement JWT Middleware]",
    "Step Number": 11,
    "Step Type": "Document",
    "Step Name": "Add JSDoc comments and inline documentation",
    "Status": "Done",
    "Is Preparatory": false,
    "Required for Completion": true,
    "Attempts": 1,
    "Duration": "40 seconds",
    "Completed At": "2026-01-18T18:39:30Z"
  }
]
```

---

## Sample MCP Registry Entries

```json
[
  {
    "MCP Name": "Social Pixl (NocoDB)",
    "Server Name": "user-NocoDB Base - Social Pixl",
    "Category": "Project Management",
    "Description": "NocoDB database for project management. Provides CRUD operations on Projects, Features, Tasks, and all protocol tracking tables.",
    "Capabilities": ["CRUD", "Query", "Filter", "Sort"],
    "Status": "Enabled",
    "Required By Protocols": ["Ralph"],
    "Used By Protocols": ["Ralph", "Test", "Security", "Deploy", "Debug", "Audit"],
    "Documentation URL": "https://docs.nocodb.com",
    "Last Tested": "2026-01-18T17:00:00Z"
  },
  {
    "MCP Name": "Nx",
    "Server Name": "user-nrwl.angular-console-extension-nx-mcp",
    "Category": "Build",
    "Description": "Nx monorepo tooling for building, testing, and linting projects in the Nx workspace.",
    "Capabilities": ["Build", "Test", "Query", "Profile"],
    "Status": "Enabled",
    "Required By Protocols": ["Test"],
    "Used By Protocols": ["Ralph", "Test", "Deploy", "Audit"],
    "Documentation URL": "https://nx.dev/mcp",
    "Last Tested": "2026-01-18T17:00:00Z"
  },
  {
    "MCP Name": "Supabase",
    "Server Name": "user-supabase",
    "Category": "Database",
    "Description": "Supabase backend for database operations, authentication, and migrations.",
    "Capabilities": ["CRUD", "Query", "Deploy"],
    "Status": "Enabled",
    "Used By Protocols": ["Ralph", "Security", "Deploy"],
    "Connection URL": "https://supabase.com/dashboard",
    "Last Tested": "2026-01-18T17:00:00Z"
  },
  {
    "MCP Name": "Vercel",
    "Server Name": "user-vercel",
    "Category": "Deployment",
    "Description": "Vercel platform for deploying frontend applications and serverless functions.",
    "Capabilities": ["Deploy", "Query"],
    "Status": "Enabled",
    "Used By Protocols": ["Deploy"],
    "Connection URL": "https://vercel.com/dashboard",
    "Last Tested": "2026-01-18T17:00:00Z"
  },
  {
    "MCP Name": "Browser",
    "Server Name": "cursor-ide-browser",
    "Category": "Browser",
    "Description": "Browser automation for testing UI, taking screenshots, and interacting with web applications.",
    "Capabilities": ["Test", "Profile", "Debug"],
    "Status": "Enabled",
    "Required By Protocols": ["Performance"],
    "Used By Protocols": ["Ralph", "Test", "Debug", "Performance"],
    "Last Tested": "2026-01-18T17:00:00Z"
  },
  {
    "MCP Name": "Chrome DevTools",
    "Server Name": "user-chrome-devtools",
    "Category": "Browser",
    "Description": "Chrome DevTools integration for performance profiling, network analysis, and debugging.",
    "Capabilities": ["Profile", "Debug"],
    "Status": "Enabled",
    "Required By Protocols": ["Performance"],
    "Used By Protocols": ["Debug", "Performance", "Audit"],
    "Last Tested": "2026-01-18T17:00:00Z"
  }
]
```

---

## How to Use This Template

### Option 1: Manual Entry
1. Complete Phase 1 setup from implementation guide
2. Copy these JSON objects
3. Manually create records in Social Pixl UI
4. Paste field values from JSON

### Option 2: Import (if NocoDB supports)
1. Check if NocoDB has CSV/JSON import
2. Format this data as CSV
3. Import into each table

### Option 3: MCP Script
1. Use `createRecords` MCP calls
2. Create records programmatically
3. Agent can do this for you

---

## Testing Workflow After Setup

1. **Verify Data**: Check all links between records work
2. **Test Protocol Invocation**: Try "Start Ralph Protocol on User Authentication"
3. **Check Tracking**: Verify agent creates Protocol Session record
4. **Test Checklist**: Verify agent creates Task Checklist records
5. **Test Checkpoint**: Trigger a blocker, verify Human Checkpoint created
6. **View Dashboard**: Check Projects → Features → Tasks hierarchy

---

## Expected Results

After importing this sample data, you should have:

- ✅ 1 Active Project (NocoDB Development)
- ✅ 3 Features (Agent Protocol, Auth, Collaboration)
- ✅ 12 Tasks (6 for Agent Protocol, 6 for Auth)
- ✅ 1 Active Protocol Session (if testing Ralph)
- ✅ 11 Checklist Steps (for JWT Middleware task)
- ✅ 1 Pending Checkpoint (SMTP blocker example)
- ✅ 6 MCP Registry entries

This provides a realistic example of how your project management system will look in production use.

---

**Document Version**: 1.0  
**Created**: 2026-01-18  
**Purpose**: Quick start template for testing Social Pixl setup

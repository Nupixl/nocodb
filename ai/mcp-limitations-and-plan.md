# Social Pixl Implementation Plan
## MCP Limitations and Workarounds

**Date**: 2026-01-19  
**Status**: Schema operations require NocoDB UI access  

---

## ⚠️ Important Discovery

The current **NocoDB MCP** (`user-NocoDB Base - Social Pixl`) provides **data operations only**:

### Available MCP Operations ✅
- `getTablesList` - List tables
- `getTableSchema` - Get table structure  
- `queryRecords` - Query records with filters
- `createRecords` - Create new records
- `updateRecords` - Update records
- `deleteRecords` - Delete records
- `getRecord` - Get single record
- `countRecords` - Count records
- `aggregate_single` - Aggregate data
- `readAttachment` - Read attachments

### NOT Available in MCP ❌
- Create tables
- Add fields to tables
- Modify field types
- Create relationships/links
- Add formulas or rollups
- Modify table schema

---

## 📋 Implementation Approach

### Phase 1: Manual Schema Setup (Required)
**You must use the NocoDB UI** to create tables and fields.

**Estimated Time**: 2-3 hours  
**Follow**: `social-pixl-implementation-guide.md`

### Phase 2: Automated Data Population (via MCP)
Once schema is ready, agent can populate sample data using MCP.

---

## 🎯 Recommended Workflow

### Step 1: Access Your NocoDB Instance
You need to open NocoDB in a browser. The instance is:
- **Base Name**: Social Pixl
- **Base ID**: `pck3oh0t2pbz35u`
- **Workspace ID**: `w4v2xe0h`

**Current Tables**:
- Project (ID: `mfk971t8h2y1wl8`) - Only has: Id, Title
- Task (ID: `mj2wedhjln0dhgd`) - Only has: Id, Title
- Subtask (ID: `mpp8oinun8mci5s`) - Only has: Id, Title

---

### Step 2: Follow Implementation Guide
Open `ai/social-pixl-implementation-guide.md` and follow Phase 1:

1. Enhance Projects table (add 16 fields)
2. Create Features table (14 fields)
3. Enhance Tasks table (add 27 fields)
4. Create Protocol Sessions table (15 fields)
5. Create Human Checkpoints table (11 fields)

---

### Step 3: Get Updated Table IDs
After creating new tables, run this to get their IDs:

```javascript
CallMcpTool: user-NocoDB Base - Social Pixl / getTablesList
{}
```

Save the IDs to use in agent rules.

---

### Step 4: Populate Sample Data (I can help with this!)
Once schema is ready, tell me and I'll use the MCP to:
- Create sample projects
- Create sample features
- Create sample tasks
- Link them together
- Set up example protocol sessions

---

## 🔧 Alternative Approaches

### Option A: NocoDB API (If you have API access)
If you have direct API access to NocoDB, we could use REST API calls via shell/curl to create schema programmatically.

**Would require**:
- NocoDB API token
- Base API endpoint
- Using Shell tool with curl commands

### Option B: NocoDB SDK
If NocoDB has a Node.js SDK with schema modification capabilities, we could:
1. Install the SDK
2. Write a migration script
3. Run it to create all tables/fields

### Option C: Database Direct Access
If you have direct PostgreSQL access to NocoDB's database:
1. Write SQL migration scripts
2. Apply them directly to database
3. NocoDB would pick up changes

---

## ✅ What I CAN Do Right Now

### 1. Verify Current State
I can check your current tables and show you what's there.

### 2. Prepare Sample Data
I can create JSON files with all sample data ready to import once schema is set up.

### 3. Create Migration Scripts
I can write scripts (SQL, API calls, or Node.js) that could create the schema if you have the right access.

### 4. Test Data Operations
Once schema is ready, I can test creating/querying/updating records.

### 5. Update Documentation
I can create more detailed guides, checklists, and reference materials.

---

## 🚀 Fastest Path Forward

### Recommended: Hybrid Approach

**You do** (30-60 minutes):
1. Open NocoDB UI
2. Use the implementation guide as reference
3. Create the most critical tables first:
   - Enhance Projects (add Status, Priority, Description)
   - Create Features table (basic fields)
   - Enhance Tasks (add Status, Task Type, Priority)

**I do** (automated):
1. Verify schema via MCP
2. Populate with sample data
3. Test all operations
4. Create protocol sessions
5. Validate relationships

---

## 📊 Current Table Status

### Project Table
```
Table ID: mfk971t8h2y1wl8
Current Fields: Id, Title
Missing: 14 fields (Status, Priority, Description, Repository Path, etc.)
```

### Task Table
```
Table ID: mj2wedhjln0dhgd
Current Fields: Id, Title
Missing: 25 fields (Status, Task Type, Feature link, Ralph Status, etc.)
```

### Subtask Table
```
Table ID: mpp8oinun8mci5s
Current Fields: Id, Title
Missing: 6 fields (Task link, Status, Assigned To, etc.)
```

### New Tables Needed
- Features (doesn't exist)
- Protocol Sessions (doesn't exist)
- Human Checkpoints (doesn't exist)
- Task Checklists (doesn't exist)
- Agent Iterations Log (doesn't exist)
- MCP Registry (doesn't exist)

---

## 💡 Quick Win: Minimal Viable Schema

If you want to **start testing immediately** with minimal setup:

### Critical Tables (Do These First)
1. **Projects**: Add just Status, Priority, Description
2. **Features**: Create with Feature Name, Project (link), Status
3. **Tasks**: Add Status, Task Type, Feature (link), Priority

### Result
You'd have basic project management working and could test:
- Creating projects
- Creating features linked to projects
- Creating tasks linked to features
- Querying the hierarchy
- Basic protocol tracking

**Time**: 15-20 minutes in NocoDB UI

---

## 🔍 What Would You Like To Do?

### Option 1: Full Schema Setup
- I'll guide you through the UI step-by-step
- You create tables/fields manually
- I verify and populate data via MCP
- **Time**: 2-3 hours
- **Result**: Complete system

### Option 2: Minimal Setup
- You create just the critical fields
- I populate test data
- We validate basic workflow
- **Time**: 20-30 minutes
- **Result**: Basic testing ready

### Option 3: API/Script Approach
- You provide API credentials or SDK access
- I write automation scripts
- We run them to create everything
- **Time**: 1-2 hours (if API supports schema operations)
- **Result**: Fully automated

### Option 4: I Create SQL/Scripts for Later
- I create migration scripts
- You run them when you have database access
- **Time**: 30 minutes for me to write
- **Result**: Scripts ready for execution

---

## 📝 Next Steps

Please let me know:

1. **Do you have access to NocoDB UI?** (Can you log in and add fields?)
2. **Do you have NocoDB API credentials?** (For programmatic schema changes)
3. **Which approach do you prefer?** (Full setup, minimal, or scripted)
4. **How much time do you have now?** (I can guide accordingly)

Once I know your preference, I'll:
- Guide you through the process, OR
- Write automation scripts, OR
- Prepare everything for later execution

---

## 🎯 My Recommendation

**Start with Minimal Setup** (Option 2):
1. Spend 20 minutes adding critical fields in NocoDB UI
2. I'll populate sample data via MCP
3. We test basic workflow with Ralph Protocol
4. You see value immediately
5. Then expand to full schema when ready

This gets you **80% of value with 20% of effort** and lets you:
- Test the protocol system today
- See real data flowing through Social Pixl
- Validate the concept before full commitment
- Iterate based on actual usage

**Want to start with this approach?** I'll give you the exact 10 fields to add first.

---

**Document Version**: 1.0  
**Created**: 2026-01-19  
**Status**: Awaiting user decision on implementation approach

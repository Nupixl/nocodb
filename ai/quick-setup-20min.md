# Social Pixl Quick Setup - Minimal Viable Schema
## Get Started in 20 Minutes

**Goal**: Set up enough to test protocol system immediately  
**Time**: 15-20 minutes in NocoDB UI  
**Result**: Working project management + protocol tracking

---

## 🎯 Phase 0: Minimal Setup (Do This First!)

### What You'll Create
1. Enhance **Projects** table (3 fields)
2. Create **Features** table (5 fields)
3. Enhance **Tasks** table (8 fields)
4. Create **Protocol Sessions** table (6 fields)

**Total**: 4 tables, 22 fields

---

## 📋 Step-by-Step Instructions

### Access NocoDB
1. Open your NocoDB instance in browser
2. Navigate to **Social Pixl** base
3. You should see: Project, Task, Subtask tables

---

### Table 1: Enhance Projects (3 fields)

**Current**: Id, Title  
**Add these 3 fields**:

#### Field 1: Description
1. Click **+ Add Field** (or click on column header dropdown → Insert Right)
2. **Field Name**: `Description`
3. **Field Type**: `Long Text`
4. Click **Save**

#### Field 2: Status
1. Click **+ Add Field**
2. **Field Name**: `Status`
3. **Field Type**: `Single Select`
4. **Options** (click "+ Add Option" for each):
   - `Active` (color: green)
   - `On Hold` (color: yellow)
   - `Completed` (color: blue)
   - `Archived` (color: gray)
5. **Default Value**: `Active`
6. Click **Save**

#### Field 3: Priority
1. Click **+ Add Field**
2. **Field Name**: `Priority`
3. **Field Type**: `Single Select`
4. **Options**:
   - `P0 (Critical)` (color: red)
   - `P1 (High)` (color: orange)
   - `P2 (Medium)` (color: yellow)
   - `P3 (Low)` (color: green)
5. **Default Value**: `P2 (Medium)`
6. Click **Save**

✅ **Projects table ready!**

---

### Table 2: Create Features (5 fields)

1. Click **+ Create Table** (left sidebar or top menu)
2. **Table Name**: `Features`
3. Click **Create**

**NocoDB will auto-create**: Id, Title

**Now add these 3 more fields**:

#### Field 1: Rename "Title" to "Feature Name"
1. Click on "Title" column header
2. Select "Edit Field"
3. Change **Field Name** to `Feature Name`
4. Click **Save**

#### Field 2: Project (Link)
1. Click **+ Add Field**
2. **Field Name**: `Project`
3. **Field Type**: `Link to Another Record`
4. **Choose Table**: `Project` (from dropdown)
5. **Link Type**: `Many to One` (Many features belong to one project)
6. Click **Save**

#### Field 3: Status
1. Click **+ Add Field**
2. **Field Name**: `Status`
3. **Field Type**: `Single Select`
4. **Options**:
   - `Planned` (gray)
   - `In Progress` (blue)
   - `Blocked` (red)
   - `Completed` (green)
   - `Cancelled` (dark gray)
5. **Default Value**: `Planned`
6. Click **Save**

#### Field 4: Priority
1. Click **+ Add Field**
2. **Field Name**: `Priority`
3. **Field Type**: `Single Select`
4. **Options**: `P0 (Critical)`, `P1 (High)`, `P2 (Medium)`, `P3 (Low)`
5. **Default Value**: `P2 (Medium)`
6. Click **Save**

#### Field 5: Description
1. Click **+ Add Field**
2. **Field Name**: `Description`
3. **Field Type**: `Long Text`
4. Click **Save**

✅ **Features table ready!**

---

### Table 3: Enhance Tasks (8 fields)

**Navigate to Task table** (should already exist)

**Current**: Id, Title  
**Add these 8 fields**:

#### Field 1: Feature (Link)
1. Click **+ Add Field**
2. **Field Name**: `Feature`
3. **Field Type**: `Link to Another Record`
4. **Choose Table**: `Features`
5. **Link Type**: `Many to One`
6. Click **Save**

#### Field 2: Description
1. **Field Name**: `Description`
2. **Field Type**: `Long Text`
3. Click **Save**

#### Field 3: Status
1. **Field Name**: `Status`
2. **Field Type**: `Single Select`
3. **Options**: `Todo`, `In Progress`, `Blocked`, `Review`, `Done`
4. **Default Value**: `Todo`
5. Click **Save**

#### Field 4: Task Type
1. **Field Name**: `Task Type`
2. **Field Type**: `Single Select`
3. **Options**: `Research`, `Implementation`, `Testing`, `Documentation`, `Refactor`, `Bug Fix`, `Deploy`
4. Click **Save**

#### Field 5: Priority
1. **Field Name**: `Priority`
2. **Field Type**: `Number`
3. **Default Value**: `3`
4. Click **Save**

#### Field 6: Ralph Status
1. **Field Name**: `Ralph Status`
2. **Field Type**: `Single Select`
3. **Options**: `Pending`, `Active`, `Paused`, `Complete`, `Failed`, `Blocked`
4. **Default Value**: `Pending`
5. Click **Save**

#### Field 7: Max Iterations
1. **Field Name**: `Max Iterations`
2. **Field Type**: `Number`
3. **Default Value**: `20`
4. Click **Save**

#### Field 8: Current Iteration
1. **Field Name**: `Current Iteration`
2. **Field Type**: `Number`
3. **Default Value**: `0`
4. Click **Save**

✅ **Tasks table ready!**

---

### Table 4: Create Protocol Sessions (6 fields)

1. Click **+ Create Table**
2. **Table Name**: `Protocol Sessions`
3. Click **Create**

**Auto-created**: Id, Title

**Change "Title" to "Session ID"**:
1. Click "Title" column → Edit Field
2. Change to `Session ID`
3. Click **Save**

**Add these 5 more fields**:

#### Field 1: Protocol Name
1. **Field Name**: `Protocol Name`
2. **Field Type**: `Single Select`
3. **Options**: `Ralph`, `Test`, `Security`, `Deploy`, `Debug`, `Audit`
4. Click **Save**

#### Field 2: Feature (Link)
1. **Field Name**: `Feature`
2. **Field Type**: `Link to Another Record`
3. **Choose Table**: `Features`
4. **Link Type**: `Many to One`
5. Click **Save**

#### Field 3: Status
1. **Field Name**: `Status`
2. **Field Type**: `Single Select`
3. **Options**: `Active`, `Paused`, `Complete`, `Terminated`, `Failed`
4. **Default Value**: `Active`
5. Click **Save**

#### Field 4: Scope
1. **Field Name**: `Scope`
2. **Field Type**: `Long Text`
3. Click **Save**

#### Field 5: Started At
1. **Field Name**: `Started At`
2. **Field Type**: `DateTime`
3. **Default Value**: `Now` (check "Auto-fill with current date/time on creation")
4. Click **Save**

✅ **Protocol Sessions table ready!**

---

## ✅ Verification Checklist

After setup, verify:

- [ ] Projects table has: Id, Title, Description, Status, Priority (5 fields total)
- [ ] Features table has: Id, Feature Name, Project, Status, Priority, Description (6 fields total)
- [ ] Tasks table has: Id, Title, Feature, Description, Status, Task Type, Priority, Ralph Status, Max Iterations, Current Iteration (10 fields total)
- [ ] Protocol Sessions table has: Id, Session ID, Protocol Name, Feature, Status, Scope, Started At (7 fields total)
- [ ] Can click on Project link in Features and see relationship
- [ ] Can click on Feature link in Tasks and see relationship

---

## 🎯 What's Next?

Once setup complete, tell me:

> "Schema is ready"

And I'll:
1. ✅ Get updated table IDs via MCP
2. ✅ Create sample data (projects, features, tasks)
3. ✅ Populate your Social Pixl instance
4. ✅ Test querying the hierarchy
5. ✅ Verify protocol tracking works

---

## 📊 What This Enables

With this minimal schema, you can:
- ✅ Track projects with status and priority
- ✅ Break projects into features
- ✅ Break features into tasks
- ✅ Track task execution with Ralph Protocol
- ✅ See protocol sessions and their status
- ✅ Query the full hierarchy
- ✅ Test the agent workflow

---

## 🚀 Testing After Setup

I'll help you test by:

1. **Creating sample project**: "NocoDB Development"
2. **Creating sample feature**: "Agent Protocol System"
3. **Creating sample tasks**: 3 tasks for the feature
4. **Creating protocol session**: Simulating Ralph Protocol execution
5. **Querying everything**: Showing the full hierarchy

You'll see:
```
Project: NocoDB Development (Active, P0)
  └─ Feature: Agent Protocol System (In Progress, P0)
      ├─ Task 1: Create Protocol Rules (Done)
      ├─ Task 2: Design Schema (Done)
      └─ Task 3: Implement Tables (In Progress)
          └─ Protocol Session: ralph-session-001 (Active)
```

---

## ⏱️ Time Estimate

- **Projects table**: 3 minutes (3 fields)
- **Features table**: 5 minutes (5 fields + new table)
- **Tasks table**: 6 minutes (8 fields)
- **Protocol Sessions table**: 5 minutes (6 fields + new table)

**Total**: ~20 minutes

---

## 💡 Pro Tips

1. **Use keyboard shortcuts**: In NocoDB, you can use keyboard to navigate faster
2. **Copy field settings**: When creating similar fields (like Status), you can duplicate and modify
3. **Save often**: NocoDB auto-saves, but verify changes appear
4. **Test links**: After creating link fields, add test data to verify they work
5. **Take screenshot**: Capture your schema for reference

---

## 🆘 If You Get Stuck

Common issues:

**Can't find "+ Add Field"**:
- Look for column header dropdown menu
- Or look for "+ Add Column" button at the right

**Link field not working**:
- Make sure target table exists first
- Refresh page if target table just created

**Status colors not showing**:
- Colors are optional, focus on creating options first
- Can add colors later by editing field

---

## 📞 Alternative: Show Me Your Screen

If you prefer, you can:
1. Open NocoDB
2. Share screen or take screenshots
3. I'll walk you through each step in real-time

Or if you have **direct database access**, I can write SQL scripts to create everything instantly.

---

**Ready to start?** Open NocoDB and let's get this done! 🚀

Once you're done (or if you need help during setup), just say:
- "Done with Projects" (and I'll verify)
- "Done with Features" (and I'll verify)
- "Done with Tasks" (and I'll verify)
- "All done!" (and I'll populate sample data)

Or if you hit any issues:
- "Having trouble with [specific step]"
- "Can't find [specific button/option]"
- "Need help with [specific field]"

I'm here to guide you through it! 💪

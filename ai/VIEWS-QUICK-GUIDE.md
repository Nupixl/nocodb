# Social Pixl Views - Quick Guide 🎨
## Your New Kanban Boards & Filtered Views

**URL**: https://social-pixl-production.up.railway.app

---

## 🎯 **Quick Access to Views**

### **Task Table Views**

| View Name | Type | Purpose | When to Use |
|-----------|------|---------|-------------|
| **Task Board** 📋 | Kanban | Drag tasks through workflow | Daily task management |
| **Ralph Protocol Board** 🤖 | Kanban | Track protocol execution | Monitor agent work |
| **Todo Tasks** ✅ | Filtered Grid | See all pending tasks | Planning your day |
| **In Progress Tasks** 🔄 | Filtered Grid | Current work only | Focus on active work |
| **Blocked Tasks** 🚫 | Filtered Grid | Tasks needing help | Problem-solving session |
| **Ralph Active** ⚡ | Filtered Grid | Active protocol tasks | Monitor live protocols |
| **Tasks by Priority** 🎯 | Sorted Grid | Highest priority first | Prioritize your work |

---

### **Features Table Views**

| View Name | Type | Purpose | When to Use |
|-----------|------|---------|-------------|
| **Features Board** 🎨 | Kanban | Visual roadmap | Feature planning |
| **In Progress Features** 🔄 | Filtered Grid | Active features | Track current development |
| **Blocked Features** 🚫 | Filtered Grid | Features needing attention | Unblock development |

---

## 📊 **Kanban Board Columns**

### **Task Board Columns**
```
Todo → In Progress → Blocked → Review → Done
```

**How to Use**:
1. New tasks start in "Todo"
2. Drag to "In Progress" when you start
3. Move to "Blocked" if stuck
4. "Review" for tasks awaiting approval
5. "Done" when complete!

---

### **Ralph Protocol Board Columns**
```
Pending → Active → Paused → Complete → Failed → Blocked
```

**How to Use**:
1. Tasks start "Pending" before protocol runs
2. "Active" when Ralph Protocol is executing
3. "Paused" when waiting for human input
4. "Complete" when successfully done
5. "Failed" if protocol couldn't complete
6. "Blocked" when needs intervention

---

### **Features Board Columns**
```
Planned → In Progress → Blocked → Completed → Cancelled
```

**How to Use**:
1. New features start "Planned"
2. Move to "In Progress" when development starts
3. "Blocked" if dependencies aren't met
4. "Completed" when feature is done
5. "Cancelled" if no longer needed

---

## 🎨 **How to Switch Views**

### **In NocoDB UI**:
1. Open your table (Task, Features, etc.)
2. Look for view dropdown (top left, next to table name)
3. Click dropdown
4. Select the view you want
5. View instantly switches!

### **Via URL**:
Each view has a unique URL you can bookmark:
```
https://social-pixl-production.up.railway.app/nc/{baseId}#{viewId}
```

---

## 💡 **View Usage Scenarios**

### **Morning Planning**
1. Open **"Todo Tasks"** view
2. See all pending work, sorted by priority
3. Drag top tasks to "In Progress" in **Task Board**
4. Start working!

### **During Development**
1. Use **"In Progress Tasks"** to focus
2. Switch to **Task Board** to update status
3. Check **"Ralph Active"** to monitor agent work

### **Problem Solving**
1. Open **"Blocked Tasks"** view
2. See all blockers at once
3. Resolve issues
4. Move tasks back to "In Progress"

### **Feature Planning**
1. Open **"Features Board"**
2. Add new features to "Planned" column
3. Drag to "In Progress" when ready
4. Track progress visually

### **Protocol Monitoring**
1. Open **"Ralph Protocol Board"**
2. See all protocol executions
3. Watch tasks move through stages
4. Intervene when tasks hit "Blocked" or "Paused"

---

## 🔧 **Customizing Views**

### **Add More Filters**
1. Open any view
2. Click filter icon (funnel)
3. Add conditions (e.g., "Assigned To = Me")
4. Save view

### **Change Sorting**
1. Open view
2. Click sort icon
3. Choose field and direction
4. Save

### **Hide/Show Columns**
1. Click column menu (three dots)
2. Select "Hide Field"
3. Customize what you see

### **Create New View**
1. Click "+ Add View" button
2. Choose type (Grid, Kanban, Gallery, Calendar, Form)
3. Name your view
4. Configure filters/sorts
5. Save!

---

## 📱 **Mobile Usage**

All views work on mobile!
- Kanban boards are touch-friendly
- Drag and drop works on tablets
- Filtered views perfect for phone screens

---

## 🎯 **Pro Tips**

### **Keyboard Shortcuts**
- `Ctrl/Cmd + K` - Quick search
- `Ctrl/Cmd + /` - Command palette
- Arrow keys - Navigate cells
- Enter - Edit cell

### **Bulk Operations**
- Select multiple records (checkbox)
- Update status for all at once
- Move multiple tasks together

### **View Sharing**
- Share specific views with team members
- Different permissions per view
- Embed views in other tools

### **View Combinations**
- Open multiple views in tabs
- Compare different perspectives
- Monitor multiple workflows

---

## 🚀 **Recommended Daily Workflow**

### **Morning** (9:00 AM)
1. Open **"Todo Tasks"**
2. Review priorities
3. Move top 3 to **"In Progress"** in Task Board

### **During Day**
1. Work from **"In Progress Tasks"** view
2. Update **Task Board** as status changes
3. Check **"Ralph Active"** periodically

### **Afternoon Check** (2:00 PM)
1. Review **"Blocked Tasks"**
2. Resolve blockers
3. Check **"Features Board"** for progress

### **End of Day** (5:00 PM)
1. Update **Task Board** with final statuses
2. Move completed tasks to "Done"
3. Plan tomorrow's **"Todo Tasks"**

---

## 📊 **View Analytics**

### **What You Can Track**
- Tasks in each status (count per column)
- Time in each stage (how long in "In Progress")
- Blocker frequency (how often tasks get blocked)
- Completion rates (tasks done per day/week)
- Protocol success rates (Ralph completions)

### **How to Analyze**
1. Use filtered views to count records
2. Export data to CSV for analysis
3. Create custom reports
4. Track trends over time

---

## 🎨 **View Color Coding**

Status colors help you see status at a glance:

**Task Status**:
- 🟦 Todo (gray)
- 🔵 In Progress (blue)
- 🔴 Blocked (red)
- 🟡 Review (yellow)
- 🟢 Done (green)

**Ralph Status**:
- ⚪ Pending (gray)
- 🔵 Active (blue)
- 🟡 Paused (yellow)
- 🟢 Complete (green)
- 🔴 Failed (red)
- 🟠 Blocked (orange)

---

## 💾 **Saving Your Preferences**

NocoDB remembers:
- Your last used view per table
- Column widths you've adjusted
- Filters you've applied
- Sort orders you've set

Everything persists across sessions!

---

## 🆘 **Troubleshooting**

### **Can't see views?**
- Refresh the page
- Check you're on the right table
- Look for view dropdown (top left)

### **Kanban not showing columns?**
- Status field needs options configured
- See `IMPLEMENTATION-COMPLETE.md` for setup

### **Drag and drop not working?**
- Make sure you're in Kanban view
- Check browser compatibility
- Try refreshing page

---

## 🎉 **You're Ready!**

Your Social Pixl instance now has:
- ✅ 10 professional views
- ✅ 3 Kanban boards
- ✅ 7 filtered/sorted views
- ✅ Complete visual workflow

**Start managing your projects visually!** 🚀

---

**Quick Access**: https://social-pixl-production.up.railway.app  
**Full Guide**: `VIEWS-AND-ENHANCEMENTS-COMPLETE.md`  
**Schema Reference**: `social-pixl-schema.md`

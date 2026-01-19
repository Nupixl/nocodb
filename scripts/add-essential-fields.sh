#!/bin/bash

# NocoDB API Configuration
API_URL="https://social-pixl-production.up.railway.app/api/v1"
TOKEN="nzq6bTvFHNBZwO-LEWrmgZHspeSnKvkTXZAoUsiC"

# Table IDs
PROJECT_TABLE="mfk971t8h2y1wl8"
FEATURES_TABLE="m8bvci8fysoixv4"
TASK_TABLE="mj2wedhjln0dhgd"
PROTOCOL_TABLE="ms4eb1nv9fpoeiz"

echo "🔧 Adding Essential Fields for Project Management..."
echo "===================================================="
echo ""

# Function to add column
add_column() {
    local table_id=$1
    local column_data=$2
    local column_name=$3
    
    echo "Adding field: $column_name..."
    curl -s -X POST "$API_URL/db/meta/tables/$table_id/columns" \
      -H "xc-token: $TOKEN" \
      -H "Content-Type: application/json" \
      -d "$column_data" > /dev/null
    
    if [ $? -eq 0 ]; then
        echo "✅ $column_name added"
    else
        echo "❌ Failed to add $column_name"
    fi
    sleep 0.3
}

echo "📋 ENHANCING PROJECT TABLE"
echo "--------------------------"
echo ""

# Add Start Date
add_column "$PROJECT_TABLE" '{
  "column_name": "Start_Date",
  "title": "Start Date",
  "uidt": "Date",
  "dt": "date"
}' "Start Date"

# Add Target Completion
add_column "$PROJECT_TABLE" '{
  "column_name": "Target_Completion",
  "title": "Target Completion",
  "uidt": "Date",
  "dt": "date"
}' "Target Completion"

# Add Actual Completion
add_column "$PROJECT_TABLE" '{
  "column_name": "Actual_Completion",
  "title": "Actual Completion",
  "uidt": "Date",
  "dt": "date"
}' "Actual Completion"

# Add Tech Stack
add_column "$PROJECT_TABLE" '{
  "column_name": "Tech_Stack",
  "title": "Tech Stack",
  "uidt": "MultiSelect",
  "dt": "text"
}' "Tech Stack"

# Add Environment Local
add_column "$PROJECT_TABLE" '{
  "column_name": "Environment_Local",
  "title": "Environment Local",
  "uidt": "SingleLineText",
  "dt": "text"
}' "Environment Local"

# Add Environment Staging
add_column "$PROJECT_TABLE" '{
  "column_name": "Environment_Staging",
  "title": "Environment Staging",
  "uidt": "URL",
  "dt": "text"
}' "Environment Staging"

# Add Environment Production
add_column "$PROJECT_TABLE" '{
  "column_name": "Environment_Production",
  "title": "Environment Production",
  "uidt": "URL",
  "dt": "text"
}' "Environment Production"

echo ""
echo "📋 ENHANCING FEATURES TABLE"
echo "---------------------------"
echo ""

# Add Complexity
add_column "$FEATURES_TABLE" '{
  "column_name": "Complexity",
  "title": "Complexity",
  "uidt": "SingleSelect",
  "dt": "text"
}' "Complexity"

# Add Required MCPs
add_column "$FEATURES_TABLE" '{
  "column_name": "Required_MCPs",
  "title": "Required MCPs",
  "uidt": "MultiSelect",
  "dt": "text"
}' "Required MCPs"

# Add Success Criteria
add_column "$FEATURES_TABLE" '{
  "column_name": "Success_Criteria",
  "title": "Success Criteria",
  "uidt": "LongText",
  "dt": "text"
}' "Success Criteria"

# Add Blockers
add_column "$FEATURES_TABLE" '{
  "column_name": "Blockers",
  "title": "Blockers",
  "uidt": "LongText",
  "dt": "text"
}' "Blockers"

# Add Assigned To
add_column "$FEATURES_TABLE" '{
  "column_name": "Assigned_To",
  "title": "Assigned To",
  "uidt": "SingleLineText",
  "dt": "text"
}' "Assigned To"

# Add Started At
add_column "$FEATURES_TABLE" '{
  "column_name": "Started_At",
  "title": "Started At",
  "uidt": "DateTime",
  "dt": "timestamp"
}' "Started At"

# Add Completed At
add_column "$FEATURES_TABLE" '{
  "column_name": "Completed_At",
  "title": "Completed At",
  "uidt": "DateTime",
  "dt": "timestamp"
}' "Completed At"

echo ""
echo "📋 ENHANCING TASK TABLE"
echo "-----------------------"
echo ""

# Add Estimated Time
add_column "$TASK_TABLE" '{
  "column_name": "Estimated_Time",
  "title": "Estimated Time",
  "uidt": "SingleLineText",
  "dt": "text"
}' "Estimated Time"

# Add Actual Time
add_column "$TASK_TABLE" '{
  "column_name": "Actual_Time",
  "title": "Actual Time",
  "uidt": "SingleLineText",
  "dt": "text"
}' "Actual Time"

# Add Required MCPs
add_column "$TASK_TABLE" '{
  "column_name": "Required_MCPs",
  "title": "Required MCPs",
  "uidt": "MultiSelect",
  "dt": "text"
}' "Required MCPs"

# Add File Paths
add_column "$TASK_TABLE" '{
  "column_name": "File_Paths",
  "title": "File Paths",
  "uidt": "LongText",
  "dt": "text"
}' "File Paths"

# Add Assigned To
add_column "$TASK_TABLE" '{
  "column_name": "Assigned_To",
  "title": "Assigned To",
  "uidt": "SingleLineText",
  "dt": "text"
}' "Assigned To"

# Add Started At
add_column "$TASK_TABLE" '{
  "column_name": "Started_At",
  "title": "Started At",
  "uidt": "DateTime",
  "dt": "timestamp"
}' "Started At"

# Add Completed At
add_column "$TASK_TABLE" '{
  "column_name": "Completed_At",
  "title": "Completed At",
  "uidt": "DateTime",
  "dt": "timestamp"
}' "Completed At"

# Add Checklist Total Steps
add_column "$TASK_TABLE" '{
  "column_name": "Checklist_Total_Steps",
  "title": "Checklist Total Steps",
  "uidt": "Number",
  "dt": "integer"
}' "Checklist Total Steps"

# Add Checklist Completed Steps
add_column "$TASK_TABLE" '{
  "column_name": "Checklist_Completed",
  "title": "Checklist Completed",
  "uidt": "Number",
  "dt": "integer"
}' "Checklist Completed"

# Add Current Step
add_column "$TASK_TABLE" '{
  "column_name": "Current_Step",
  "title": "Current Step",
  "uidt": "SingleLineText",
  "dt": "text"
}' "Current Step"

# Add Failure Count
add_column "$TASK_TABLE" '{
  "column_name": "Failure_Count",
  "title": "Failure Count",
  "uidt": "Number",
  "dt": "integer"
}' "Failure Count"

# Add Last Error
add_column "$TASK_TABLE" '{
  "column_name": "Last_Error",
  "title": "Last Error",
  "uidt": "LongText",
  "dt": "text"
}' "Last Error"

# Add Local Log Path
add_column "$TASK_TABLE" '{
  "column_name": "Local_Log_Path",
  "title": "Local Log Path",
  "uidt": "SingleLineText",
  "dt": "text"
}' "Local Log Path"

# Add Agent Notes
add_column "$TASK_TABLE" '{
  "column_name": "Agent_Notes",
  "title": "Agent Notes",
  "uidt": "LongText",
  "dt": "text"
}' "Agent Notes"

echo ""
echo "📋 ENHANCING PROTOCOL SESSIONS TABLE"
echo "------------------------------------"
echo ""

# Add Iterations Used
add_column "$PROTOCOL_TABLE" '{
  "column_name": "Iterations_Used",
  "title": "Iterations Used",
  "uidt": "Number",
  "dt": "integer"
}' "Iterations Used"

# Add Max Iterations
add_column "$PROTOCOL_TABLE" '{
  "column_name": "Max_Iterations",
  "title": "Max Iterations",
  "uidt": "Number",
  "dt": "integer"
}' "Max Iterations"

# Add Human Interventions
add_column "$PROTOCOL_TABLE" '{
  "column_name": "Human_Interventions",
  "title": "Human Interventions",
  "uidt": "Number",
  "dt": "integer"
}' "Human Interventions"

# Add Outcome Summary
add_column "$PROTOCOL_TABLE" '{
  "column_name": "Outcome_Summary",
  "title": "Outcome Summary",
  "uidt": "LongText",
  "dt": "text"
}' "Outcome Summary"

# Add Session Log Path
add_column "$PROTOCOL_TABLE" '{
  "column_name": "Session_Log_Path",
  "title": "Session Log Path",
  "uidt": "SingleLineText",
  "dt": "text"
}' "Session Log Path"

# Add Completed At
add_column "$PROTOCOL_TABLE" '{
  "column_name": "Completed_At",
  "title": "Completed At",
  "uidt": "DateTime",
  "dt": "timestamp"
}' "Completed At"

echo ""
echo "===================================================="
echo "✅ Essential Fields Added!"
echo ""
echo "Project Table Enhanced:"
echo "  - Dates: Start, Target Completion, Actual Completion"
echo "  - Tech Stack (multi-select)"
echo "  - Environments: Local, Staging, Production"
echo ""
echo "Features Table Enhanced:"
echo "  - Complexity, Required MCPs"
echo "  - Success Criteria, Blockers"
echo "  - Assigned To, Started/Completed timestamps"
echo ""
echo "Task Table Enhanced:"
echo "  - Time tracking: Estimated, Actual"
echo "  - Required MCPs, File Paths"
echo "  - Assigned To, timestamps"
echo "  - Ralph Protocol fields: Checklist progress, Current Step"
echo "  - Failure tracking: Count, Last Error"
echo "  - Local Log Path, Agent Notes"
echo ""
echo "Protocol Sessions Enhanced:"
echo "  - Iteration tracking: Used, Max"
echo "  - Human Interventions count"
echo "  - Outcome Summary, Session Log Path"
echo "  - Completed At timestamp"
echo ""
echo "🎉 Your Social Pixl platform is now fully equipped!"
echo ""

#!/bin/bash

# NocoDB API Configuration  
API_URL="https://social-pixl-production.up.railway.app/api/v1"
TOKEN="nzq6bTvFHNBZwO-LEWrmgZHspeSnKvkTXZAoUsiC"
BASE_ID="pck3oh0t2pbz35u"

# Table IDs
TASK_TABLE="mj2wedhjln0dhgd"
FEATURES_TABLE="m8bvci8fysoixv4"

echo "🚀 Phase 2: Enhancing Tasks and Creating Protocol Sessions..."
echo "=============================================================="
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
    sleep 0.5
}

echo "📋 Enhancing Task table..."

# Add Feature link
add_column "$TASK_TABLE" '{
  "column_name": "Feature",
  "title": "Feature",
  "uidt": "LinkToAnotherRecord",
  "parentId": "'"$FEATURES_TABLE"'",
  "childId": "'"$TASK_TABLE"'",
  "type": "mm"
}' "Feature (Link)"

# Add Description
add_column "$TASK_TABLE" '{
  "column_name": "Description",
  "title": "Description",
  "uidt": "LongText",
  "dt": "text"
}' "Description"

# Add Status
add_column "$TASK_TABLE" '{
  "column_name": "Status",
  "title": "Status",
  "uidt": "SingleSelect",
  "dt": "text",
  "dtxp": "{\"options\":[{\"title\":\"Todo\",\"color\":\"gray\"},{\"title\":\"In Progress\",\"color\":\"blue\"},{\"title\":\"Blocked\",\"color\":\"red\"},{\"title\":\"Review\",\"color\":\"yellow\"},{\"title\":\"Done\",\"color\":\"green\"}]}"
}' "Status"

# Add Task Type
add_column "$TASK_TABLE" '{
  "column_name": "Task_Type",
  "title": "Task Type",
  "uidt": "SingleSelect",
  "dt": "text",
  "dtxp": "{\"options\":[{\"title\":\"Research\"},{\"title\":\"Implementation\"},{\"title\":\"Testing\"},{\"title\":\"Documentation\"},{\"title\":\"Refactor\"},{\"title\":\"Bug Fix\"},{\"title\":\"Deploy\"}]}"
}' "Task Type"

# Add Priority
add_column "$TASK_TABLE" '{
  "column_name": "Priority",
  "title": "Priority",
  "uidt": "Number",
  "dt": "integer"
}' "Priority"

# Add Ralph Status
add_column "$TASK_TABLE" '{
  "column_name": "Ralph_Status",
  "title": "Ralph Status",
  "uidt": "SingleSelect",
  "dt": "text",
  "dtxp": "{\"options\":[{\"title\":\"Pending\",\"color\":\"gray\"},{\"title\":\"Active\",\"color\":\"blue\"},{\"title\":\"Paused\",\"color\":\"yellow\"},{\"title\":\"Complete\",\"color\":\"green\"},{\"title\":\"Failed\",\"color\":\"red\"},{\"title\":\"Blocked\",\"color\":\"orange\"}]}"
}' "Ralph Status"

# Add Max Iterations
add_column "$TASK_TABLE" '{
  "column_name": "Max_Iterations",
  "title": "Max Iterations",
  "uidt": "Number",
  "dt": "integer"
}' "Max Iterations"

# Add Current Iteration
add_column "$TASK_TABLE" '{
  "column_name": "Current_Iteration",
  "title": "Current Iteration",
  "uidt": "Number",
  "dt": "integer"
}' "Current Iteration"

# Add Completion Promise
add_column "$TASK_TABLE" '{
  "column_name": "Completion_Promise",
  "title": "Completion Promise",
  "uidt": "SingleLineText",
  "dt": "text"
}' "Completion Promise"

# Add Blockers
add_column "$TASK_TABLE" '{
  "column_name": "Blockers",
  "title": "Blockers",
  "uidt": "LongText",
  "dt": "text"
}' "Blockers"

echo ""
echo "✅ Task table enhancement complete!"
echo ""

# Create Protocol Sessions table
echo "📋 Creating Protocol Sessions table..."
curl -s -X POST "$API_URL/db/meta/projects/$BASE_ID/tables" \
  -H "xc-token: $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "table_name": "Protocol_Sessions",
    "title": "Protocol Sessions",
    "columns": [
      {
        "column_name": "id",
        "title": "Id",
        "uidt": "ID",
        "dt": "int4",
        "pk": true,
        "ai": true,
        "rqd": true,
        "un": true
      },
      {
        "column_name": "Session_ID",
        "title": "Session ID",
        "uidt": "SingleLineText",
        "dt": "text",
        "pv": true
      }
    ]
  }' > /tmp/protocol_sessions.json

PROTOCOL_TABLE_ID=$(cat /tmp/protocol_sessions.json | python3 -c "import sys, json; print(json.load(sys.stdin)['id'])" 2>/dev/null)

if [ ! -z "$PROTOCOL_TABLE_ID" ]; then
    echo "✅ Protocol Sessions table created (ID: $PROTOCOL_TABLE_ID)"
    echo ""
    
    echo "📋 Adding fields to Protocol Sessions table..."
    
    # Add Protocol Name
    add_column "$PROTOCOL_TABLE_ID" '{
      "column_name": "Protocol_Name",
      "title": "Protocol Name",
      "uidt": "SingleSelect",
      "dt": "text",
      "dtxp": "{\"options\":[{\"title\":\"Ralph\"},{\"title\":\"Test\"},{\"title\":\"Security\"},{\"title\":\"Deploy\"},{\"title\":\"Debug\"},{\"title\":\"Audit\"}]}"
    }' "Protocol Name"
    
    # Add Feature link
    add_column "$PROTOCOL_TABLE_ID" '{
      "column_name": "Feature",
      "title": "Feature",
      "uidt": "LinkToAnotherRecord",
      "parentId": "'"$FEATURES_TABLE"'",
      "childId": "'"$PROTOCOL_TABLE_ID"'",
      "type": "mm"
    }' "Feature (Link)"
    
    # Add Status
    add_column "$PROTOCOL_TABLE_ID" '{
      "column_name": "Status",
      "title": "Status",
      "uidt": "SingleSelect",
      "dt": "text",
      "dtxp": "{\"options\":[{\"title\":\"Active\",\"color\":\"blue\"},{\"title\":\"Paused\",\"color\":\"yellow\"},{\"title\":\"Complete\",\"color\":\"green\"},{\"title\":\"Terminated\",\"color\":\"gray\"},{\"title\":\"Failed\",\"color\":\"red\"}]}"
    }' "Status"
    
    # Add Scope
    add_column "$PROTOCOL_TABLE_ID" '{
      "column_name": "Scope",
      "title": "Scope",
      "uidt": "LongText",
      "dt": "text"
    }' "Scope"
    
    # Add Invoked By User
    add_column "$PROTOCOL_TABLE_ID" '{
      "column_name": "Invoked_By_User",
      "title": "Invoked By User",
      "uidt": "LongText",
      "dt": "text"
    }' "Invoked By User"
    
    echo ""
    echo "✅ Protocol Sessions table complete!"
else
    echo "❌ Failed to create Protocol Sessions table"
fi

echo ""
echo "=============================================================="
echo "✅ Phase 2 Complete!"
echo ""
echo "Tables enhanced/created:"
echo "  - Task (enhanced with 10+ Ralph Protocol fields)"
echo "  - Protocol Sessions (created with 6 fields)"
echo ""
echo "Protocol Sessions Table ID: $PROTOCOL_TABLE_ID"
echo ""

#!/bin/bash

# NocoDB API Configuration
API_URL="https://social-pixl-production.up.railway.app/api/v1"
TOKEN="nzq6bTvFHNBZwO-LEWrmgZHspeSnKvkTXZAoUsiC"
BASE_ID="pck3oh0t2pbz35u"

# Table IDs
PROTOCOL_SESSIONS_TABLE="ms4eb1nv9fpoeiz"
PROJECT_TABLE="mfk971t8h2y1wl8"
TASK_TABLE="mj2wedhjln0dhgd"
SUBTASK_TABLE="mpp8oinun8mci5s"

echo "🛠️ Adjusting Protocol Sessions Schema..."
echo "=========================================="

# Function to add column
add_column() {
    local table_id=$1
    local column_data=$2
    local column_name=$3
    
    echo "Adding field: $column_name..."
    curl -s -X POST "$API_URL/db/meta/tables/$table_id/columns" \
      -H "xc-token: $TOKEN" \
      -H "Content-Type: application/json" \
      -d "$column_data"
    echo ""
}

# 1. Add Project (Link) to Protocol Sessions (Already present in some instances)
# add_column "$PROTOCOL_SESSIONS_TABLE" ...

# 2. Add Task (Link) to Protocol Sessions (Already present in some instances)
# add_column "$PROTOCOL_SESSIONS_TABLE" ...

# 3. Add Subtask (Link) to Protocol Sessions
# If this fails via API, please add it manually in NocoDB UI:
# - Table: Protocol Sessions
# - Field: Subtasks
# - Type: LinkToAnotherRecord (Many-to-Many with Subtasks table)
add_column "$PROTOCOL_SESSIONS_TABLE" '{
  "column_name": "Subtasks",
  "title": "Subtasks",
  "uidt": "LinkToAnotherRecord",
  "parentId": "'"$PROTOCOL_SESSIONS_TABLE"'",
  "childId": "'"$SUBTASK_TABLE"'",
  "type": "mm"
}' "Subtask (Link)"

echo "=========================================="
echo "✅ Schema adjustment complete!"

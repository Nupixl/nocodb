#!/bin/bash

# NocoDB API Configuration
API_URL="https://social-pixl-production.up.railway.app/api/v1"
TOKEN="nzq6bTvFHNBZwO-LEWrmgZHspeSnKvkTXZAoUsiC"
BASE_ID="pck3oh0t2pbz35u"

# Table IDs
TASK_TABLE="mj2wedhjln0dhgd"
FEATURES_TABLE="m8bvci8fysoixv4"
PROJECT_TABLE="mfk971t8h2y1wl8"

# Column IDs
TASK_STATUS_COL="chnvbzaj1i9g06i"
TASK_TYPE_COL="cmc3v37oi3kfhkw"
TASK_PRIORITY_COL="cktfqzzsli2b2ci"
TASK_RALPH_STATUS_COL="cng8g49am7p5yxc"
TASK_MCP_COL="chg6wn1w47ivml0"

FEATURES_STATUS_COL="c6fs0n3gvhriq94"
FEATURES_PRIORITY_COL="czfsw7di1ox7y2n"
FEATURES_COMPLEXITY_COL="c3pvvvf73ruolul"
FEATURES_MCP_COL="czgpz4kfuvkyj7r"

PROJECT_STATUS_COL="c86bec153x4aeyj"
PROJECT_PRIORITY_COL="c1jer06qg5rq5wz"
PROJECT_TECH_COL="cdruyli81rzto45"

echo "🧹 Fixing select fields and creating Subtask table..."
echo "======================================================"

# Function to fix a select field
fix_select() {
    local col_id=$1
    local title=$2
    local options_json=$3
    
    echo "Fixing: $title..."
    curl -s -X PATCH "$API_URL/db/meta/columns/$col_id" \
      -H "xc-token: $TOKEN" \
      -H "Content-Type: application/json" \
      -d '{
        "dtxp": "'"$options_json"'",
        "colOptions": {
          "options": '"$options_json"'
        }
      }' > /dev/null
}

# --- FIX TASK TABLE ---
fix_select "$TASK_STATUS_COL" "Task Status" '[{"title":"Todo","color":"#808080"},{"title":"Drafted","color":"#95A5A6"},{"title":"In Progress","color":"#3366FF"},{"title":"In Review","color":"#FFD700"},{"title":"Done","color":"#00CC66"},{"title":"Archived","color":"#696969"}]'
fix_select "$TASK_TYPE_COL" "Task Type" '[{"title":"Research","color":"#9B59B6"},{"title":"Implementation","color":"#3498DB"},{"title":"Testing","color":"#E67E22"},{"title":"Documentation","color":"#95A5A6"},{"title":"Refactor","color":"#1ABC9C"},{"title":"Bug Fix","color":"#E74C3C"},{"title":"Deploy","color":"#2ECC71"}]'
fix_select "$TASK_PRIORITY_COL" "Task Priority" '[{"title":"P0 (Critical)","color":"#FF0000"},{"title":"P1 (High)","color":"#FF8C00"},{"title":"P2 (Medium)","color":"#FFD700"},{"title":"P3 (Low)","color":"#00CC66"}]'
fix_select "$TASK_RALPH_STATUS_COL" "Ralph Status" '[{"title":"Pending","color":"#808080"},{"title":"Active","color":"#3366FF"},{"title":"Paused","color":"#FFD700"},{"title":"Complete","color":"#00CC66"},{"title":"Failed","color":"#FF3333"},{"title":"Blocked","color":"#FF8C00"}]'
fix_select "$TASK_MCP_COL" "Task MCPs" '[{"title":"Nx","color":"#3366FF"},{"title":"Supabase","color":"#00CC66"},{"title":"Vercel","color":"#000000"},{"title":"Railway","color":"#8B00FF"},{"title":"Browser","color":"#FF8C00"},{"title":"Chrome DevTools","color":"#4285F4"},{"title":"Plaid","color":"#00D4FF"},{"title":"DocuSign","color":"#FFD700"},{"title":"Social Pixl","color":"#FF1493"}]'

# --- FIX FEATURES TABLE ---
fix_select "$FEATURES_STATUS_COL" "Features Status" '[{"title":"Planned","color":"#808080"},{"title":"In Progress","color":"#3366FF"},{"title":"Blocked","color":"#FF3333"},{"title":"Completed","color":"#00CC66"},{"title":"Cancelled","color":"#696969"}]'
fix_select "$FEATURES_PRIORITY_COL" "Features Priority" '[{"title":"P0 (Critical)","color":"#FF0000"},{"title":"P1 (High)","color":"#FF8C00"},{"title":"P2 (Medium)","color":"#FFD700"},{"title":"P3 (Low)","color":"#00CC66"}]'
fix_select "$FEATURES_COMPLEXITY_COL" "Complexity" '[{"title":"XS","color":"#00CC66"},{"title":"S","color":"#3366FF"},{"title":"M","color":"#FFD700"},{"title":"L","color":"#FF8C00"},{"title":"XL","color":"#FF3333"}]'
fix_select "$FEATURES_MCP_COL" "Features MCPs" '[{"title":"Nx","color":"#3366FF"},{"title":"Supabase","color":"#00CC66"},{"title":"Vercel","color":"#000000"},{"title":"Railway","color":"#8B00FF"},{"title":"Browser","color":"#FF8C00"},{"title":"Chrome DevTools","color":"#4285F4"},{"title":"Plaid","color":"#00D4FF"},{"title":"DocuSign","color":"#FFD700"},{"title":"Social Pixl","color":"#FF1493"}]'

# --- FIX PROJECT TABLE ---
fix_select "$PROJECT_STATUS_COL" "Project Status" '[{"title":"Drafted","color":"#95A5A6"},{"title":"In Progress","color":"#3366FF"},{"title":"In Review","color":"#FFD700"},{"title":"Live","color":"#00CC66"},{"title":"Cancelled","color":"#E74C3C"},{"title":"Archived","color":"#808080"}]'
fix_select "$PROJECT_PRIORITY_COL" "Project Priority" '[{"title":"P0 (Critical)","color":"#FF0000"},{"title":"P1 (High)","color":"#FF8C00"},{"title":"P2 (Medium)","color":"#FFD700"},{"title":"P3 (Low)","color":"#00CC66"}]'
fix_select "$PROJECT_TECH_COL" "Tech Stack" '[{"title":"TypeScript","color":"#3178C6"},{"title":"JavaScript","color":"#F7DF1E"},{"title":"Node.js","color":"#339933"},{"title":"React","color":"#61DAFB"},{"title":"Vue.js","color":"#4FC08D"},{"title":"PostgreSQL","color":"#336791"},{"title":"MongoDB","color":"#47A248"},{"title":"Docker","color":"#2496ED"},{"title":"Nx","color":"#143055"}]'

# --- CREATE SUBTASK TABLE ---
echo "Creating Subtask table..."
SUBTASK_RESPONSE=$(curl -s -X POST "$API_URL/db/meta/projects/$BASE_ID/tables" \
  -H "xc-token: $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "table_name": "Subtask",
    "title": "Subtasks",
    "columns": [
      {"column_name": "Id", "title": "Id", "uidt": "ID", "pk": true, "ai": true},
      {"column_name": "Title", "title": "Title", "uidt": "SingleLineText", "rqd": true},
      {"column_name": "Status", "title": "Status", "uidt": "SingleSelect", "rqd": true, 
       "dtxp": "[{\"title\":\"Todo\",\"color\":\"#808080\"},{\"title\":\"In Progress\",\"color\":\"#3366FF\"},{\"title\":\"Done\",\"color\":\"#00CC66\"}]",
       "colOptions": {"options": [{"title":"Todo","color":"#808080"},{"title":"In Progress","color":"#3366FF"},{"title":"Done","color":"#00CC66"}]}
      },
      {"column_name": "Description", "title": "Description", "uidt": "LongText"}
    ]
  }')

SUBTASK_ID=$(echo "$SUBTASK_RESPONSE" | python3 -c "import sys, json; print(json.load(sys.stdin).get('id', ''))")

if [ ! -z "$SUBTASK_ID" ]; then
    echo "✅ Subtask table created (ID: $SUBTASK_ID)"
    
    # Link Subtask to Task
    echo "Linking Subtask to Task..."
    curl -s -X POST "$API_URL/db/meta/tables/$SUBTASK_ID/columns" \
      -H "xc-token: $TOKEN" \
      -H "Content-Type: application/json" \
      -d '{
        "column_name": "Task",
        "title": "Task",
        "uidt": "LinkToAnotherRecord",
        "parentId": "'"$TASK_TABLE"'",
        "childId": "'"$SUBTASK_ID"'",
        "type": "mm"
      }' > /dev/null
else
    echo "❌ Failed to create Subtask table"
    echo "$SUBTASK_RESPONSE"
fi

echo "======================================================"
echo "✅ Maintenance complete! All fields fixed and Subtask table created."

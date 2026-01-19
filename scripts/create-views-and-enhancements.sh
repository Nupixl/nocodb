#!/bin/bash

# NocoDB API Configuration
API_URL="https://social-pixl-production.up.railway.app/api/v1"
TOKEN="nzq6bTvFHNBZwO-LEWrmgZHspeSnKvkTXZAoUsiC"
BASE_ID="pck3oh0t2pbz35u"

# Table IDs
PROJECT_TABLE="mfk971t8h2y1wl8"
FEATURES_TABLE="m8bvci8fysoixv4"
TASK_TABLE="mj2wedhjln0dhgd"
PROTOCOL_TABLE="ms4eb1nv9fpoeiz"

# Column IDs
TASK_STATUS_COL="chnvbzaj1i9g06i"
TASK_RALPH_STATUS_COL="cng8g49am7p5yxc"
TASK_PRIORITY_COL="cktfqzzsli2b2ci"
FEATURES_STATUS_COL="c6fs0n3gvhriq94"

echo "🎨 Creating Kanban Views and Enhancements..."
echo "=============================================="
echo ""

# Function to create view
create_view() {
    local table_id=$1
    local view_data=$2
    local view_name=$3
    
    echo "Creating view: $view_name..."
    response=$(curl -s -X POST "$API_URL/db/meta/tables/$table_id/views" \
      -H "xc-token: $TOKEN" \
      -H "Content-Type: application/json" \
      -d "$view_data")
    
    view_id=$(echo "$response" | python3 -c "import sys, json; print(json.load(sys.stdin).get('id', ''))" 2>/dev/null)
    
    if [ ! -z "$view_id" ]; then
        echo "✅ $view_name created (ID: $view_id)"
        echo "$view_id"
    else
        echo "❌ Failed to create $view_name"
        echo ""
    fi
}

# Function to add filter to view
add_filter() {
    local view_id=$1
    local filter_data=$2
    local filter_name=$3
    
    echo "  Adding filter: $filter_name..."
    curl -s -X POST "$API_URL/db/meta/views/$view_id/filters" \
      -H "xc-token: $TOKEN" \
      -H "Content-Type: application/json" \
      -d "$filter_data" > /dev/null
    
    if [ $? -eq 0 ]; then
        echo "  ✅ Filter added"
    fi
}

# Function to add sort to view
add_sort() {
    local view_id=$1
    local sort_data=$2
    local sort_name=$3
    
    echo "  Adding sort: $sort_name..."
    curl -s -X POST "$API_URL/db/meta/views/$view_id/sorts" \
      -H "xc-token: $TOKEN" \
      -H "Content-Type: application/json" \
      -d "$sort_data" > /dev/null
    
    if [ $? -eq 0 ]; then
        echo "  ✅ Sort added"
    fi
}

echo "📋 TASK TABLE VIEWS"
echo "-------------------"
echo ""

# 1. Task Board (Kanban by Status)
echo "1️⃣ Creating Task Board (Kanban by Status)..."
view_id=$(create_view "$TASK_TABLE" '{
  "title": "Task Board",
  "type": 2,
  "fk_grp_col_id": "'"$TASK_STATUS_COL"'",
  "show_system_fields": false
}' "Task Board")
echo ""

# 2. Ralph Protocol Board (Kanban by Ralph Status)
echo "2️⃣ Creating Ralph Protocol Board..."
view_id=$(create_view "$TASK_TABLE" '{
  "title": "Ralph Protocol Board",
  "type": 2,
  "fk_grp_col_id": "'"$TASK_RALPH_STATUS_COL"'",
  "show_system_fields": false
}' "Ralph Protocol Board")
echo ""

# 3. Todo Tasks (Grid view with filter)
echo "3️⃣ Creating Todo Tasks view..."
view_id=$(create_view "$TASK_TABLE" '{
  "title": "Todo Tasks",
  "type": 3,
  "show_system_fields": false
}' "Todo Tasks")

if [ ! -z "$view_id" ]; then
    add_filter "$view_id" '{
      "fk_column_id": "'"$TASK_STATUS_COL"'",
      "comparison_op": "eq",
      "value": "Todo"
    }' "Status = Todo"
    
    add_sort "$view_id" '{
      "fk_column_id": "'"$TASK_PRIORITY_COL"'",
      "direction": "asc"
    }' "Priority ascending"
fi
echo ""

# 4. In Progress Tasks
echo "4️⃣ Creating In Progress Tasks view..."
view_id=$(create_view "$TASK_TABLE" '{
  "title": "In Progress Tasks",
  "type": 3,
  "show_system_fields": false
}' "In Progress Tasks")

if [ ! -z "$view_id" ]; then
    add_filter "$view_id" '{
      "fk_column_id": "'"$TASK_STATUS_COL"'",
      "comparison_op": "eq",
      "value": "In Progress"
    }' "Status = In Progress"
fi
echo ""

# 5. Blocked Tasks
echo "5️⃣ Creating Blocked Tasks view..."
view_id=$(create_view "$TASK_TABLE" '{
  "title": "Blocked Tasks",
  "type": 3,
  "show_system_fields": false
}' "Blocked Tasks")

if [ ! -z "$view_id" ]; then
    add_filter "$view_id" '{
      "fk_column_id": "'"$TASK_STATUS_COL"'",
      "comparison_op": "eq",
      "value": "Blocked"
    }' "Status = Blocked"
fi
echo ""

# 6. Ralph Active Tasks
echo "6️⃣ Creating Ralph Active Tasks view..."
view_id=$(create_view "$TASK_TABLE" '{
  "title": "Ralph Active",
  "type": 3,
  "show_system_fields": false
}' "Ralph Active")

if [ ! -z "$view_id" ]; then
    add_filter "$view_id" '{
      "fk_column_id": "'"$TASK_RALPH_STATUS_COL"'",
      "comparison_op": "eq",
      "value": "Active"
    }' "Ralph Status = Active"
fi
echo ""

# 7. Tasks by Priority
echo "7️⃣ Creating Tasks by Priority view..."
view_id=$(create_view "$TASK_TABLE" '{
  "title": "Tasks by Priority",
  "type": 3,
  "show_system_fields": false
}' "Tasks by Priority")

if [ ! -z "$view_id" ]; then
    add_sort "$view_id" '{
      "fk_column_id": "'"$TASK_PRIORITY_COL"'",
      "direction": "asc"
    }' "Priority ascending"
fi
echo ""

echo "📋 FEATURES TABLE VIEWS"
echo "-----------------------"
echo ""

# 8. Features Board (Kanban by Status)
echo "8️⃣ Creating Features Board..."
view_id=$(create_view "$FEATURES_TABLE" '{
  "title": "Features Board",
  "type": 2,
  "fk_grp_col_id": "'"$FEATURES_STATUS_COL"'",
  "show_system_fields": false
}' "Features Board")
echo ""

# 9. In Progress Features
echo "9️⃣ Creating In Progress Features view..."
view_id=$(create_view "$FEATURES_TABLE" '{
  "title": "In Progress Features",
  "type": 3,
  "show_system_fields": false
}' "In Progress Features")

if [ ! -z "$view_id" ]; then
    add_filter "$view_id" '{
      "fk_column_id": "'"$FEATURES_STATUS_COL"'",
      "comparison_op": "eq",
      "value": "In Progress"
    }' "Status = In Progress"
fi
echo ""

# 10. Blocked Features
echo "🔟 Creating Blocked Features view..."
view_id=$(create_view "$FEATURES_TABLE" '{
  "title": "Blocked Features",
  "type": 3,
  "show_system_fields": false
}' "Blocked Features")

if [ ! -z "$view_id" ]; then
    add_filter "$view_id" '{
      "fk_column_id": "'"$FEATURES_STATUS_COL"'",
      "comparison_op": "eq",
      "value": "Blocked"
    }' "Status = Blocked"
fi
echo ""

echo "=============================================="
echo "✅ View Creation Complete!"
echo ""
echo "Views Created:"
echo "  Task Table:"
echo "    - Task Board (Kanban by Status)"
echo "    - Ralph Protocol Board (Kanban by Ralph Status)"
echo "    - Todo Tasks (filtered)"
echo "    - In Progress Tasks (filtered)"
echo "    - Blocked Tasks (filtered)"
echo "    - Ralph Active (filtered)"
echo "    - Tasks by Priority (sorted)"
echo ""
echo "  Features Table:"
echo "    - Features Board (Kanban by Status)"
echo "    - In Progress Features (filtered)"
echo "    - Blocked Features (filtered)"
echo ""
echo "🎨 Open your Social Pixl instance to see the new views!"
echo ""

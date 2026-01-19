#!/bin/bash

# NocoDB API Configuration
API_URL="https://social-pixl-production.up.railway.app/api/v1"
TOKEN="nzq6bTvFHNBZwO-LEWrmgZHspeSnKvkTXZAoUsiC"

# Table IDs
TASK_TABLE="mj2wedhjln0dhgd"
FEATURES_TABLE="m8bvci8fysoixv4"

# Column IDs
TASK_STATUS_COL="chnvbzaj1i9g06i"
TASK_RALPH_STATUS_COL="cng8g49am7p5yxc"
FEATURES_STATUS_COL="c6fs0n3gvhriq94"

echo "🎨 Creating Kanban Views via API..."
echo "===================================="
echo ""

# Function to create Kanban view
create_kanban() {
    local table_id=$1
    local title=$2
    local group_col_id=$3
    
    echo "Creating Kanban: $title..."
    response=$(curl -s -X POST "$API_URL/db/meta/tables/$table_id/kanbans" \
      -H "xc-token: $TOKEN" \
      -H "Content-Type: application/json" \
      -d '{
        "title": "'"$title"'",
        "fk_grp_col_id": "'"$group_col_id"'"
      }')
    
    view_id=$(echo "$response" | python3 -c "import sys, json; print(json.load(sys.stdin).get('id', ''))" 2>/dev/null)
    
    if [ ! -z "$view_id" ]; then
        echo "✅ $title created (ID: $view_id)"
    else
        echo "❌ Failed to create $title"
        echo "$response"
    fi
    echo ""
    sleep 0.5
}

# Function to create Grid view
create_grid() {
    local table_id=$1
    local title=$2
    
    echo "Creating Grid: $title..."
    response=$(curl -s -X POST "$API_URL/db/meta/tables/$table_id/grids" \
      -H "xc-token: $TOKEN" \
      -H "Content-Type: application/json" \
      -d '{
        "title": "'"$title"'"
      }')
    
    view_id=$(echo "$response" | python3 -c "import sys, json; print(json.load(sys.stdin).get('id', ''))" 2>/dev/null)
    
    if [ ! -z "$view_id" ]; then
        echo "✅ $title created (ID: $view_id)"
        echo "$view_id"
    else
        echo "❌ Failed to create $title"
    fi
    echo ""
    sleep 0.5
}

# Function to add filter
add_filter() {
    local view_id=$1
    local column_id=$2
    local value=$3
    local filter_name=$4
    
    echo "  Adding filter: $filter_name..."
    curl -s -X POST "$API_URL/db/meta/views/$view_id/filters" \
      -H "xc-token: $TOKEN" \
      -H "Content-Type: application/json" \
      -d '{
        "fk_column_id": "'"$column_id"'",
        "comparison_op": "eq",
        "value": "'"$value"'"
      }' > /dev/null
    
    if [ $? -eq 0 ]; then
        echo "  ✅ Filter added"
    fi
    sleep 0.3
}

# Function to add sort
add_sort() {
    local view_id=$1
    local column_id=$2
    local direction=$3
    local sort_name=$4
    
    echo "  Adding sort: $sort_name..."
    curl -s -X POST "$API_URL/db/meta/views/$view_id/sorts" \
      -H "xc-token: $TOKEN" \
      -H "Content-Type: application/json" \
      -d '{
        "fk_column_id": "'"$column_id"'",
        "direction": "'"$direction"'"
      }' > /dev/null
    
    if [ $? -eq 0 ]; then
        echo "  ✅ Sort added"
    fi
    sleep 0.3
}

echo "📋 TASK TABLE KANBAN VIEWS"
echo "--------------------------"
echo ""

# 1. Task Board (Kanban by Status)
create_kanban "$TASK_TABLE" "Task Board" "$TASK_STATUS_COL"

# 2. Ralph Protocol Board (Kanban by Ralph Status)
create_kanban "$TASK_TABLE" "Ralph Protocol Board" "$TASK_RALPH_STATUS_COL"

echo "📋 TASK TABLE GRID VIEWS"
echo "------------------------"
echo ""

# 3. Todo Tasks
view_id=$(create_grid "$TASK_TABLE" "Todo Tasks")
if [ ! -z "$view_id" ]; then
    add_filter "$view_id" "$TASK_STATUS_COL" "Todo" "Status = Todo"
    add_sort "$view_id" "cktfqzzsli2b2ci" "asc" "Priority ascending"
fi

# 4. In Progress Tasks
view_id=$(create_grid "$TASK_TABLE" "In Progress Tasks")
if [ ! -z "$view_id" ]; then
    add_filter "$view_id" "$TASK_STATUS_COL" "In Progress" "Status = In Progress"
fi

# 5. Blocked Tasks
view_id=$(create_grid "$TASK_TABLE" "Blocked Tasks")
if [ ! -z "$view_id" ]; then
    add_filter "$view_id" "$TASK_STATUS_COL" "Blocked" "Status = Blocked"
fi

# 6. Ralph Active
view_id=$(create_grid "$TASK_TABLE" "Ralph Active")
if [ ! -z "$view_id" ]; then
    add_filter "$view_id" "$TASK_RALPH_STATUS_COL" "Active" "Ralph Status = Active"
fi

# 7. Tasks by Priority
view_id=$(create_grid "$TASK_TABLE" "Tasks by Priority")
if [ ! -z "$view_id" ]; then
    add_sort "$view_id" "cktfqzzsli2b2ci" "asc" "Priority ascending"
fi

echo "📋 FEATURES TABLE VIEWS"
echo "-----------------------"
echo ""

# 8. Features Board (Kanban)
create_kanban "$FEATURES_TABLE" "Features Board" "$FEATURES_STATUS_COL"

# 9. In Progress Features
view_id=$(create_grid "$FEATURES_TABLE" "In Progress Features")
if [ ! -z "$view_id" ]; then
    add_filter "$view_id" "$FEATURES_STATUS_COL" "In Progress" "Status = In Progress"
fi

# 10. Blocked Features
view_id=$(create_grid "$FEATURES_TABLE" "Blocked Features")
if [ ! -z "$view_id" ]; then
    add_filter "$view_id" "$FEATURES_STATUS_COL" "Blocked" "Status = Blocked"
fi

echo "===================================="
echo "✅ All Views Created Successfully!"
echo ""
echo "Views Created:"
echo "  Task Table:"
echo "    🎨 Task Board (Kanban by Status)"
echo "    🤖 Ralph Protocol Board (Kanban by Ralph Status)"
echo "    📋 Todo Tasks (filtered + sorted)"
echo "    🔄 In Progress Tasks (filtered)"
echo "    🚫 Blocked Tasks (filtered)"
echo "    ⚡ Ralph Active (filtered)"
echo "    🎯 Tasks by Priority (sorted)"
echo ""
echo "  Features Table:"
echo "    🎨 Features Board (Kanban by Status)"
echo "    🔄 In Progress Features (filtered)"
echo "    🚫 Blocked Features (filtered)"
echo ""
echo "🎉 Open your Social Pixl instance to see the new views!"
echo "   https://social-pixl-production.up.railway.app"
echo ""

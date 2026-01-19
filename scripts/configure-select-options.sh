#!/bin/bash

# NocoDB API Configuration
API_URL="https://social-pixl-production.up.railway.app/api/v1"
TOKEN="nzq6bTvFHNBZwO-LEWrmgZHspeSnKvkTXZAoUsiC"

echo "🎨 Configuring Select Field Options..."
echo "======================================"
echo ""

# Function to update column with options
update_column_options() {
    local column_id=$1
    local options_json=$2
    local field_name=$3
    
    echo "Updating: $field_name..."
    
    response=$(curl -s -X PATCH "$API_URL/db/meta/columns/$column_id" \
      -H "xc-token: $TOKEN" \
      -H "Content-Type: application/json" \
      -d "$options_json")
    
    if echo "$response" | grep -q "id"; then
        echo "✅ $field_name options configured"
    else
        echo "❌ Failed to configure $field_name"
        echo "$response"
    fi
    echo ""
    sleep 0.5
}

echo "📋 TASK TABLE SELECT FIELDS"
echo "----------------------------"
echo ""

# Task Status
update_column_options "chnvbzaj1i9g06i" '{
  "column_name": "Status",
  "title": "Status",
  "uidt": "SingleSelect",
  "dtxp": "{\"options\":[{\"title\":\"Todo\",\"color\":\"#808080\"},{\"title\":\"In Progress\",\"color\":\"#3366FF\"},{\"title\":\"Blocked\",\"color\":\"#FF3333\"},{\"title\":\"Review\",\"color\":\"#FFD700\"},{\"title\":\"Done\",\"color\":\"#00CC66\"}]}"
}' "Task Status"

# Task Type
update_column_options "cmc3v37oi3kfhkw" '{
  "column_name": "Task_Type",
  "title": "Task Type",
  "uidt": "SingleSelect",
  "dtxp": "{\"options\":[{\"title\":\"Research\",\"color\":\"#9B59B6\"},{\"title\":\"Implementation\",\"color\":\"#3498DB\"},{\"title\":\"Testing\",\"color\":\"#E67E22\"},{\"title\":\"Documentation\",\"color\":\"#95A5A6\"},{\"title\":\"Refactor\",\"color\":\"#1ABC9C\"},{\"title\":\"Bug Fix\",\"color\":\"#E74C3C\"},{\"title\":\"Deploy\",\"color\":\"#2ECC71\"}]}"
}' "Task Type"

# Ralph Status
update_column_options "cng8g49am7p5yxc" '{
  "column_name": "Ralph_Status",
  "title": "Ralph Status",
  "uidt": "SingleSelect",
  "dtxp": "{\"options\":[{\"title\":\"Pending\",\"color\":\"#808080\"},{\"title\":\"Active\",\"color\":\"#3366FF\"},{\"title\":\"Paused\",\"color\":\"#FFD700\"},{\"title\":\"Complete\",\"color\":\"#00CC66\"},{\"title\":\"Failed\",\"color\":\"#FF3333\"},{\"title\":\"Blocked\",\"color\":\"#FF8C00\"}]}"
}' "Ralph Status"

# Task Priority
update_column_options "cktfqzzsli2b2ci" '{
  "column_name": "Priority",
  "title": "Priority",
  "uidt": "SingleSelect",
  "dtxp": "{\"options\":[{\"title\":\"P0 (Critical)\",\"color\":\"#FF0000\"},{\"title\":\"P1 (High)\",\"color\":\"#FF8C00\"},{\"title\":\"P2 (Medium)\",\"color\":\"#FFD700\"},{\"title\":\"P3 (Low)\",\"color\":\"#00CC66\"}]}"
}' "Task Priority"

# Task Required MCPs
update_column_options "chg6wn1w47ivml0" '{
  "column_name": "Required_MCPs",
  "title": "Required MCPs",
  "uidt": "MultiSelect",
  "dtxp": "{\"options\":[{\"title\":\"Nx\",\"color\":\"#3366FF\"},{\"title\":\"Supabase\",\"color\":\"#00CC66\"},{\"title\":\"Vercel\",\"color\":\"#000000\"},{\"title\":\"Railway\",\"color\":\"#8B00FF\"},{\"title\":\"Browser\",\"color\":\"#FF8C00\"},{\"title\":\"Chrome DevTools\",\"color\":\"#4285F4\"},{\"title\":\"Plaid\",\"color\":\"#00D4FF\"},{\"title\":\"DocuSign\",\"color\":\"#FFD700\"},{\"title\":\"Social Pixl\",\"color\":\"#FF1493\"}]}"
}' "Task Required MCPs"

echo "📋 FEATURES TABLE SELECT FIELDS"
echo "--------------------------------"
echo ""

# Features Status
update_column_options "c6fs0n3gvhriq94" '{
  "column_name": "Status",
  "title": "Status",
  "uidt": "SingleSelect",
  "dtxp": "{\"options\":[{\"title\":\"Planned\",\"color\":\"#808080\"},{\"title\":\"In Progress\",\"color\":\"#3366FF\"},{\"title\":\"Blocked\",\"color\":\"#FF3333\"},{\"title\":\"Completed\",\"color\":\"#00CC66\"},{\"title\":\"Cancelled\",\"color\":\"#696969\"}]}"
}' "Features Status"

# Features Priority
update_column_options "czfsw7di1ox7y2n" '{
  "column_name": "Priority",
  "title": "Priority",
  "uidt": "SingleSelect",
  "dtxp": "{\"options\":[{\"title\":\"P0 (Critical)\",\"color\":\"#FF0000\"},{\"title\":\"P1 (High)\",\"color\":\"#FF8C00\"},{\"title\":\"P2 (Medium)\",\"color\":\"#FFD700\"},{\"title\":\"P3 (Low)\",\"color\":\"#00CC66\"}]}"
}' "Features Priority"

# Features Complexity
update_column_options "c3pvvvf73ruolul" '{
  "column_name": "Complexity",
  "title": "Complexity",
  "uidt": "SingleSelect",
  "dtxp": "{\"options\":[{\"title\":\"XS\",\"color\":\"#00CC66\"},{\"title\":\"S\",\"color\":\"#3366FF\"},{\"title\":\"M\",\"color\":\"#FFD700\"},{\"title\":\"L\",\"color\":\"#FF8C00\"},{\"title\":\"XL\",\"color\":\"#FF3333\"}]}"
}' "Features Complexity"

# Features Required MCPs
update_column_options "czgpz4kfuvkyj7r" '{
  "column_name": "Required_MCPs",
  "title": "Required MCPs",
  "uidt": "MultiSelect",
  "dtxp": "{\"options\":[{\"title\":\"Nx\",\"color\":\"#3366FF\"},{\"title\":\"Supabase\",\"color\":\"#00CC66\"},{\"title\":\"Vercel\",\"color\":\"#000000\"},{\"title\":\"Railway\",\"color\":\"#8B00FF\"},{\"title\":\"Browser\",\"color\":\"#FF8C00\"},{\"title\":\"Chrome DevTools\",\"color\":\"#4285F4\"},{\"title\":\"Plaid\",\"color\":\"#00D4FF\"},{\"title\":\"DocuSign\",\"color\":\"#FFD700\"},{\"title\":\"Social Pixl\",\"color\":\"#FF1493\"}]}"
}' "Features Required MCPs"

echo "📋 PROJECT TABLE SELECT FIELDS"
echo "-------------------------------"
echo ""

# Project Status
update_column_options "c86bec153x4aeyj" '{
  "column_name": "Status",
  "title": "Status",
  "uidt": "SingleSelect",
  "dtxp": "{\"options\":[{\"title\":\"Active\",\"color\":\"#00CC66\"},{\"title\":\"On Hold\",\"color\":\"#FFD700\"},{\"title\":\"Completed\",\"color\":\"#3366FF\"},{\"title\":\"Archived\",\"color\":\"#808080\"}]}"
}' "Project Status"

# Project Priority
update_column_options "c1jer06qg5rq5wz" '{
  "column_name": "Priority",
  "title": "Priority",
  "uidt": "SingleSelect",
  "dtxp": "{\"options\":[{\"title\":\"P0 (Critical)\",\"color\":\"#FF0000\"},{\"title\":\"P1 (High)\",\"color\":\"#FF8C00\"},{\"title\":\"P2 (Medium)\",\"color\":\"#FFD700\"},{\"title\":\"P3 (Low)\",\"color\":\"#00CC66\"}]}"
}' "Project Priority"

# Project Tech Stack
update_column_options "cdruyli81rzto45" '{
  "column_name": "Tech_Stack",
  "title": "Tech Stack",
  "uidt": "MultiSelect",
  "dtxp": "{\"options\":[{\"title\":\"TypeScript\",\"color\":\"#3178C6\"},{\"title\":\"JavaScript\",\"color\":\"#F7DF1E\"},{\"title\":\"Node.js\",\"color\":\"#339933\"},{\"title\":\"React\",\"color\":\"#61DAFB\"},{\"title\":\"Vue.js\",\"color\":\"#4FC08D\"},{\"title\":\"Angular\",\"color\":\"#DD0031\"},{\"title\":\"PostgreSQL\",\"color\":\"#336791\"},{\"title\":\"MongoDB\",\"color\":\"#47A248\"},{\"title\":\"Redis\",\"color\":\"#DC382D\"},{\"title\":\"Docker\",\"color\":\"#2496ED\"},{\"title\":\"Nx\",\"color\":\"#143055\"},{\"title\":\"Vercel\",\"color\":\"#000000\"},{\"title\":\"Railway\",\"color\":\"#8B00FF\"},{\"title\":\"Supabase\",\"color\":\"#3ECF8E\"},{\"title\":\"NocoDB\",\"color\":\"#FF1493\"}]}"
}' "Project Tech Stack"

echo "======================================"
echo "✅ All Select Field Options Configured!"
echo ""
echo "Summary:"
echo "  Task Table:"
echo "    ✅ Status (5 options)"
echo "    ✅ Task Type (7 options)"
echo "    ✅ Ralph Status (6 options)"
echo "    ✅ Priority (4 options)"
echo "    ✅ Required MCPs (9 options)"
echo ""
echo "  Features Table:"
echo "    ✅ Status (5 options)"
echo "    ✅ Priority (4 options)"
echo "    ✅ Complexity (5 options)"
echo "    ✅ Required MCPs (9 options)"
echo ""
echo "  Project Table:"
echo "    ✅ Status (4 options)"
echo "    ✅ Priority (4 options)"
echo "    ✅ Tech Stack (15 options)"
echo ""
echo "🎨 Your Kanban boards will now show proper columns!"
echo "   Open: https://social-pixl-production.up.railway.app"
echo ""

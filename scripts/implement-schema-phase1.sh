#!/bin/bash

# NocoDB API Configuration
API_URL="https://social-pixl-production.up.railway.app/api/v1"
TOKEN="nzq6bTvFHNBZwO-LEWrmgZHspeSnKvkTXZAoUsiC"
BASE_ID="pck3oh0t2pbz35u"

# Table IDs
PROJECT_TABLE="mfk971t8h2y1wl8"
TASK_TABLE="mj2wedhjln0dhgd"

echo "🚀 Starting Social Pixl Schema Implementation..."
echo "================================================"
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
}

# Add Status field to Project
echo "📋 Enhancing Project table..."
add_column "$PROJECT_TABLE" '{
  "column_name": "Status",
  "title": "Status",
  "uidt": "SingleSelect",
  "dt": "text",
  "dtxp": "{\"options\":[{\"title\":\"Active\",\"color\":\"green\"},{\"title\":\"On Hold\",\"color\":\"yellow\"},{\"title\":\"Completed\",\"color\":\"blue\"},{\"title\":\"Archived\",\"color\":\"gray\"}]}"
}' "Status"

# Add Priority field to Project
add_column "$PROJECT_TABLE" '{
  "column_name": "Priority",
  "title": "Priority",
  "uidt": "SingleSelect",
  "dt": "text",
  "dtxp": "{\"options\":[{\"title\":\"P0 (Critical)\",\"color\":\"red\"},{\"title\":\"P1 (High)\",\"color\":\"orange\"},{\"title\":\"P2 (Medium)\",\"color\":\"yellow\"},{\"title\":\"P3 (Low)\",\"color\":\"green\"}]}"
}' "Priority"

# Add Repository Path
add_column "$PROJECT_TABLE" '{
  "column_name": "Repository_Path",
  "title": "Repository Path",
  "uidt": "SingleLineText",
  "dt": "text"
}' "Repository Path"

# Add Repository URL
add_column "$PROJECT_TABLE" '{
  "column_name": "Repository_URL",
  "title": "Repository URL",
  "uidt": "URL",
  "dt": "text"
}' "Repository URL"

# Add Owner
add_column "$PROJECT_TABLE" '{
  "column_name": "Owner",
  "title": "Owner",
  "uidt": "SingleLineText",
  "dt": "text"
}' "Owner"

# Add Notes
add_column "$PROJECT_TABLE" '{
  "column_name": "Notes",
  "title": "Notes",
  "uidt": "LongText",
  "dt": "text"
}' "Notes"

echo ""
echo "✅ Project table enhancement complete!"
echo ""

# Now create Features table
echo "📋 Creating Features table..."
curl -s -X POST "$API_URL/db/meta/projects/$BASE_ID/tables" \
  -H "xc-token: $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "table_name": "Features",
    "title": "Features",
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
        "column_name": "Feature_Name",
        "title": "Feature Name",
        "uidt": "SingleLineText",
        "dt": "text",
        "pv": true
      }
    ]
  }' > /tmp/features_table.json

FEATURES_TABLE_ID=$(cat /tmp/features_table.json | python3 -c "import sys, json; print(json.load(sys.stdin)['id'])" 2>/dev/null)

if [ ! -z "$FEATURES_TABLE_ID" ]; then
    echo "✅ Features table created (ID: $FEATURES_TABLE_ID)"
    echo ""
    
    # Add fields to Features table
    echo "📋 Adding fields to Features table..."
    
    add_column "$FEATURES_TABLE_ID" '{
      "column_name": "Description",
      "title": "Description",
      "uidt": "LongText",
      "dt": "text"
    }' "Description"
    
    add_column "$FEATURES_TABLE_ID" '{
      "column_name": "Status",
      "title": "Status",
      "uidt": "SingleSelect",
      "dt": "text",
      "dtxp": "{\"options\":[{\"title\":\"Planned\",\"color\":\"gray\"},{\"title\":\"In Progress\",\"color\":\"blue\"},{\"title\":\"Blocked\",\"color\":\"red\"},{\"title\":\"Completed\",\"color\":\"green\"},{\"title\":\"Cancelled\",\"color\":\"dark gray\"}]}"
    }' "Status"
    
    add_column "$FEATURES_TABLE_ID" '{
      "column_name": "Priority",
      "title": "Priority",
      "uidt": "SingleSelect",
      "dt": "text",
      "dtxp": "{\"options\":[{\"title\":\"P0 (Critical)\",\"color\":\"red\"},{\"title\":\"P1 (High)\",\"color\":\"orange\"},{\"title\":\"P2 (Medium)\",\"color\":\"yellow\"},{\"title\":\"P3 (Low)\",\"color\":\"green\"}]}"
    }' "Priority"
    
    # Create link to Project
    add_column "$FEATURES_TABLE_ID" '{
      "column_name": "Project",
      "title": "Project",
      "uidt": "LinkToAnotherRecord",
      "parentId": "'"$PROJECT_TABLE"'",
      "childId": "'"$FEATURES_TABLE_ID"'",
      "type": "mm"
    }' "Project (Link)"
    
    echo ""
    echo "✅ Features table complete!"
else
    echo "❌ Failed to create Features table"
fi

echo ""
echo "================================================"
echo "✅ Phase 1 Schema Implementation Complete!"
echo ""
echo "Tables created/enhanced:"
echo "  - Project (enhanced with 6+ fields)"
echo "  - Features (created with 4+ fields)"
echo ""
echo "Features Table ID: $FEATURES_TABLE_ID"
echo ""

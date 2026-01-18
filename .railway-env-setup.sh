#!/bin/bash
# Railway Environment Variables Setup Script
# Run this after linking your Railway project

echo "🚂 Setting up Railway environment variables for NocoDB backend..."

# Required variables
railway variables set NODE_ENV=production
railway variables set PORT=8080

# Generate a random JWT secret (you can replace this with your own)
JWT_SECRET=$(openssl rand -base64 32)
railway variables set NC_AUTH_JWT_SECRET="$JWT_SECRET"

# Database - If you have PostgreSQL added in Railway, use this:
# railway variables set NC_DB='${{Postgres.DATABASE_URL}}'
# Otherwise, you'll need to add a PostgreSQL database first

# Optional but recommended
railway variables set NC_DISABLE_TELE=true
railway variables set NC_TOOL_DIR=/usr/app/data/

echo "✅ Environment variables set!"
echo ""
echo "📝 Next steps:"
echo "1. Add a PostgreSQL database: railway add --database postgres"
echo "2. Set NC_DB variable: railway variables set NC_DB='\${{Postgres.DATABASE_URL}}'"
echo "3. Generate domain: railway domain"
echo "4. Deploy: railway up"

# Railway Quick Start Guide

Follow these steps to deploy your NocoDB backend to Railway.

## Step 1: Login to Railway CLI

```bash
railway login
```

This will open a browser window for authentication.

## Step 2: Link Your Project

```bash
cd /Users/elijahwilliams/Documents/GitHub/nocodb
railway link
```

Select your **"resplendent-emotion"** project (or the project you created in the Railway dashboard).

## Step 3: Select the Backend Service

```bash
railway service
```

Select the **"social-pixl"** service (your NocoDB backend).

## Step 4: Add PostgreSQL Database

```bash
railway add --database postgres
```

This creates a PostgreSQL database and automatically adds the `DATABASE_URL` variable.

## Step 5: Set Environment Variables

### Option A: Use the setup script (recommended)

```bash
./.railway-env-setup.sh
```

### Option B: Set variables manually

```bash
# Required
railway variables set NODE_ENV=production
railway variables set PORT=8080
railway variables set NC_AUTH_JWT_SECRET="$(openssl rand -base64 32)"

# Database (use the PostgreSQL you just added)
railway variables set NC_DB='${{Postgres.DATABASE_URL}}'

# Optional but recommended
railway variables set NC_DISABLE_TELE=true
railway variables set NC_TOOL_DIR=/usr/app/data/
```

## Step 6: Generate a Domain

```bash
railway domain
```

This will generate a public URL like `https://social-pixl-production.up.railway.app`

**Copy this URL** - you'll need it for the frontend!

## Step 7: Set the Public URL

```bash
railway variables set NC_PUBLIC_URL="<your-railway-domain>"
```

Replace `<your-railway-domain>` with the domain from Step 6.

## Step 8: Deploy

Railway should automatically deploy when you push to GitHub, but you can also trigger a manual deployment:

```bash
railway up
```

## Step 9: Check Deployment Status

```bash
railway status
```

Or view logs:

```bash
railway logs
```

## Step 10: Test Your Backend

Once deployed, test the health endpoint:

```bash
curl https://your-domain.up.railway.app/api/v1/health
```

You should see a response indicating the backend is running.

## Step 11: Update Frontend Environment Variables

In your Vercel dashboard, update the frontend environment variable:

```
NEXT_PUBLIC_API_URL=https://your-railway-domain.up.railway.app
```

Or whatever environment variable your frontend uses to connect to the backend.

## Troubleshooting

### View Logs
```bash
railway logs
```

### Check Variables
```bash
railway variables
```

### Redeploy
```bash
railway up
```

### Check Service Status
```bash
railway status
```

## Environment Variables Summary

Here's a complete list of the environment variables you should have set:

| Variable | Value | Required |
|----------|-------|----------|
| `NODE_ENV` | `production` | ✅ Yes |
| `PORT` | `8080` | ✅ Yes |
| `NC_DB` | `${{Postgres.DATABASE_URL}}` | ✅ Yes |
| `NC_AUTH_JWT_SECRET` | Random 32-byte string | ✅ Yes |
| `NC_PUBLIC_URL` | Your Railway domain | ✅ Yes |
| `NC_DISABLE_TELE` | `true` | Recommended |
| `NC_TOOL_DIR` | `/usr/app/data/` | Recommended |

## Next Steps

Once your backend is deployed:

1. ✅ Backend is running on Railway
2. ✅ Database is connected
3. ⏳ Update frontend to use Railway backend URL
4. ⏳ Test the full stack

---

**Need help?** Check the Railway logs with `railway logs` or visit the [Railway documentation](https://docs.railway.app).

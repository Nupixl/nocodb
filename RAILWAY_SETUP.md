# Railway Deployment Guide for NocoDB Backend

This guide will help you deploy the NocoDB backend to Railway.

## Prerequisites

1. A Railway account (sign up at https://railway.app)
2. Your GitHub repository connected to Railway

## Step 1: Create a New Project on Railway

1. Go to https://railway.app/dashboard
2. Click **"New Project"**
3. Select **"Deploy from GitHub repo"**
4. Choose this repository: `Nupixl/nocodb`
5. Select the `develop` branch

## Step 2: Configure the Service

Railway will automatically detect the Dockerfile and start building. Configure these settings:

### Environment Variables

Add these environment variables in the Railway dashboard:

**Required:**
```
NODE_ENV=production
PORT=8080
NC_DB=<your-database-url>
```

**Recommended:**
```
NC_AUTH_JWT_SECRET=<generate-a-random-secret>
NC_PUBLIC_URL=https://<your-railway-domain>.railway.app
NC_DISABLE_TELE=true
```

**Optional (for PostgreSQL - recommended):**

Railway provides a free PostgreSQL database. To add one:
1. Click **"+ New"** in your project
2. Select **"Database"** → **"Add PostgreSQL"**
3. Railway will automatically create a `DATABASE_URL` variable
4. Set `NC_DB=${{Postgres.DATABASE_URL}}` to use it

## Step 3: Configure Domain

1. In Railway dashboard, go to your service **Settings**
2. Under **"Networking"**, click **"Generate Domain"**
3. Copy the generated URL (e.g., `https://your-app.up.railway.app`)
4. Update `NC_PUBLIC_URL` environment variable with this URL

## Step 4: Deploy

1. Railway will automatically deploy when you push to the `develop` branch
2. Monitor the build logs in the Railway dashboard
3. Once deployed, test the health endpoint: `https://your-app.up.railway.app/api/v1/health`

## Step 5: Connect Frontend to Backend

Update your Vercel frontend environment variables:

```
NEXT_PUBLIC_API_URL=https://your-app.up.railway.app
# or whatever your frontend uses to connect to the backend
```

## Database Options

### Option 1: Railway PostgreSQL (Recommended - Free)
- Included in Railway's $5/month plan
- Automatic backups
- Easy to set up

### Option 2: External Database
- Supabase (free tier available)
- Neon (free tier available)
- Your own PostgreSQL instance

Set `NC_DB` to your database connection string:
```
# PostgreSQL
NC_DB=pg://user:password@host:port/database

# MySQL
NC_DB=mysql2://user:password@host:port/database

# SQLite (not recommended for production)
NC_DB=sqlite:///data/noco.db
```

## Monitoring

- **Logs**: View in Railway dashboard under your service
- **Metrics**: Railway provides CPU, Memory, and Network metrics
- **Health Check**: Railway will automatically restart if health check fails

## Troubleshooting

### Build Fails
- Check the build logs in Railway dashboard
- Ensure all dependencies are in `package.json`
- Verify the Dockerfile path is correct

### Service Won't Start
- Check the deployment logs
- Verify environment variables are set correctly
- Ensure `NC_DB` is a valid database connection string

### Can't Connect from Frontend
- Verify the Railway domain is correct
- Check CORS settings in NocoDB
- Ensure the health endpoint responds: `/api/v1/health`

## Cost Estimate

With Railway's Hobby plan ($5/month):
- Backend service: ~$3-4/month (included in $5 credit)
- PostgreSQL database: ~$1-2/month (included in $5 credit)
- **Total: $5/month** (as long as usage stays under $5 credit)

## Next Steps

1. Set up automatic deployments from GitHub
2. Configure custom domain (optional)
3. Set up monitoring and alerts
4. Configure backups for your database

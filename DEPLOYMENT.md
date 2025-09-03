# 🚀 Deployment Guide

## Prerequisites

1. **Wrangler CLI** installed and authenticated
   ```bash
   npm install -g wrangler
   wrangler login
   ```

2. **Cloudflare account** with Workers and D1 enabled

## Step-by-Step Deployment

### 1. Create D1 Database

```bash
# Create the database
wrangler d1 create visitor_logs

# This will output something like:
# [[d1_databases]]
# binding = "DB"
# database_name = "visitor_logs"  
# database_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

### 2. Update wrangler.toml

Replace the `database_id` in `wrangler.toml` with the ID from step 1:

```toml
[[d1_databases]]
binding = "DB"
database_name = "visitor_logs"
database_id = "your-actual-database-id-here"
```

### 3. Initialize Database Schema

```bash
# Apply the schema to your D1 database
wrangler d1 execute visitor_logs --file=./schema.sql
```

### 4. Deploy the Worker

```bash
# Deploy to Cloudflare
wrangler deploy
```

### 5. Get Admin URL

After deployment, check the logs to find your admin panel URL:

```bash
# Watch deployment logs
wrangler tail

# Look for: "Admin panel accessible at: /admin-xxxxxxxxxx"
```

### 6. Configure Custom Domain (Optional)

In the Cloudflare dashboard:
1. Go to **Workers & Pages**
2. Select your worker
3. Go to **Settings** → **Custom Domains**
4. Add your domain (e.g., `ip.pkgforge.dev`)

## Testing Your Deployment

### API Endpoints
- `https://your-domain.com/` - Static homepage
- `https://your-domain.com/json` - JSON API
- `https://your-domain.com/csv` - CSV format
- `https://your-domain.com/html` - HTML table

### Admin Panel
- `https://your-domain.com/admin-xxxxxxxxxx` - Admin dashboard

## Security Notes

1. **Keep Admin URL Secret**: The admin URL is randomly generated for security
2. **No Authentication**: Currently no login required for admin (add if needed)
3. **CORS Enabled**: API is publicly accessible (intentional for IP service)

## Monitoring

```bash
# View real-time logs
wrangler tail

# Check D1 database directly
wrangler d1 execute visitor_logs --command="SELECT COUNT(*) FROM visitor_logs"
```

## Troubleshooting

### Database Connection Issues
```bash
# Verify database exists
wrangler d1 list

# Check database schema
wrangler d1 execute visitor_logs --command="SELECT name FROM sqlite_master WHERE type='table'"
```

### Worker Not Responding
```bash
# Check worker status
wrangler whoami

# Redeploy
wrangler deploy
```

### Admin Panel Not Found
- Check worker logs for the admin URL
- Ensure database is properly initialized
- Verify D1 binding in wrangler.toml

## Development

For local development with D1:

```bash
# Start local development with D1
wrangler dev --local

# Apply schema to local database
wrangler d1 execute visitor_logs --local --file=./schema.sql
```

## Features Verification Checklist

After deployment, verify:

- [ ] Homepage loads at root URL
- [ ] All API endpoints return data (/json, /csv, etc.)
- [ ] Admin panel is accessible
- [ ] Visitor logs are being recorded
- [ ] Statistics display correctly
- [ ] Export functionality works
- [ ] Filtering works in admin panel

## Support

If you encounter issues:
1. Check Cloudflare Workers dashboard for errors
2. Review wrangler logs with `wrangler tail`
3. Verify D1 database connectivity
4. Ensure all environment variables are set correctly
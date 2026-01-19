# NocoDB API Token Setup Guide
## Getting Full API Access for Schema Operations

**Current Status**: ✅ **MCP Fully Expansive** - Schema operations now supported via MCP.
**Preferred Method**: Use the `user-NocoDB Base - Social Pixl` MCP for most agent-led operations.

---

## 🚀 Why Use the MCP Over Manual API Tokens?

The Social Pixl MCP has been expanded with:
- **Schema Management**: `columnAdd`, `viewUpdate`, etc.
- **Collaboration**: `commentAdd`, `userInvite`, etc.
- **Automation**: `hookList`.

Agents can now perform schema migrations and project management tasks directly through the standard MCP interface without you needing to manually manage API tokens or write curl scripts.

---

## 📋 When to Still Use This Guide
You may still need this guide if:
- You are writing external automation scripts (Python, Shell).
- You are using tools that don't support the MCP protocol.
- You need to perform administrative tasks not yet exposed via MCP (like creating entire new bases or workspaces).

## 🔍 Current Token Analysis

**Token**: `nzq6bTvFHNBZwO-LEWrmgZHspeSnKvkTXZAoUsiC`  
**Status**: ✅ Valid but ❌ Limited permissions  
**Permissions**: Guest role only (read-only, very restricted)

**Test Result**:
```json
{
  "roles": {
    "guest": true
  },
  "workspace_roles": null,
  "base_roles": null
}
```

---

## 📋 How to Create Proper API Token

### Step 1: Access NocoDB Settings

1. Open your NocoDB instance in browser
2. Log in with your admin account
3. Click on your profile/avatar (top right)
4. Select **"Account Settings"** or **"User Settings"**

### Step 2: Navigate to API Tokens

Look for one of these sections:
- **"API Tokens"**
- **"Developer"** → **"API Tokens"**
- **"Settings"** → **"API Tokens"**
- **"Security"** → **"Tokens"**

### Step 3: Create New Token

1. Click **"+ New Token"** or **"Create Token"**
2. **Token Name**: `Social-Pixl-Admin-Token` (or similar)
3. **Permissions/Scope**: Select **"Full Access"** or **"Admin"**
   - ✅ Workspace Admin
   - ✅ Base Editor
   - ✅ Schema Editor
4. **Expiration**: Set to "Never" or long duration
5. Click **"Create"** or **"Generate"**

### Step 4: Copy Token

⚠️ **IMPORTANT**: Copy the token immediately - it may only be shown once!

---

## 🎯 Alternative: Use Your User Auth Token

If API tokens don't work, you can use your authentication token from browser:

### Method 1: Get from Browser DevTools

1. Open NocoDB in browser
2. Open DevTools (F12 or Right-click → Inspect)
3. Go to **"Network"** tab
4. Refresh the page
5. Click on any API request
6. Look in **"Request Headers"**
7. Find `xc-token` or `xc-auth` header
8. Copy that value

### Method 2: Get from Browser Storage

1. Open NocoDB in browser
2. Open DevTools (F12)
3. Go to **"Application"** or **"Storage"** tab
4. Look in **"Local Storage"** or **"Cookies"**
5. Find key like `nc_token`, `xc-token`, or similar
6. Copy the value

---

## 🧪 Testing Your New Token

Once you have a new token, test it:

```bash
# Replace YOUR_NEW_TOKEN with actual token
curl -X GET "http://localhost:8080/api/v1/auth/user/me" \
  -H "xc-token: YOUR_NEW_TOKEN"
```

**Expected Response** (with proper permissions):
```json
{
  "id": "user_id",
  "email": "your@email.com",
  "roles": {
    "owner": true  // or "creator": true, "editor": true
  },
  "workspace_roles": {
    "w4v2xe0h": "owner"  // Your workspace ID
  },
  "base_roles": {
    "pck3oh0t2pbz35u": "owner"  // Your base ID
  }
}
```

---

## 🔐 Required Permissions for Schema Operations

Your token needs these capabilities:
- ✅ **Create tables**
- ✅ **Add/modify/delete fields**
- ✅ **Create relationships/links**
- ✅ **Modify table properties**
- ✅ **Create views**

These are typically available to:
- **Workspace Owner**
- **Workspace Creator**
- **Base Owner**
- **Base Editor** (sometimes)

---

## 📍 What's Your NocoDB Setup?

To help you further, I need to know:

### Question 1: Where is NocoDB running?
- [ ] Locally (http://localhost:8080)
- [ ] Self-hosted server (custom URL)
- [ ] NocoDB Cloud (app.nocodb.com)
- [ ] Other: _______________

### Question 2: What's your role?
- [ ] Owner/Creator (I set it up)
- [ ] Admin
- [ ] Editor
- [ ] Viewer

### Question 3: Can you access settings?
- [ ] Yes, I can see Account Settings
- [ ] No, limited access
- [ ] Not sure where to find it

---

## 🚀 Next Steps

### Option A: Get Proper Token (Recommended)
1. Follow steps above to create admin token
2. Share the new token with me
3. I'll test and implement schema via API

### Option B: Share Session Token
1. Get your auth token from browser
2. Share it with me (I'll use it immediately and securely)
3. I'll implement the schema

### Option C: Manual Setup (Fallback)
1. Follow the 20-minute quick setup guide
2. I'll populate data via the working MCP
3. No API needed

---

## ⚠️ Security Notes

- API tokens should be kept secure
- Don't share tokens in public repositories
- Tokens can be revoked/regenerated anytime
- Session tokens expire (may need to refresh)
- Admin tokens have full access - use carefully

---

## 📞 Tell Me

Once you have a new token, just say:

> "New token: [paste token here]"

Or if you prefer manual setup:

> "Let's do manual setup instead"

Or if you need help finding settings:

> "Can't find token settings, here's my NocoDB URL: [url]"

I'll help you get this working! 🚀

---

**Document Version**: 1.0  
**Created**: 2026-01-19  
**Current Token Status**: Valid but guest-only permissions

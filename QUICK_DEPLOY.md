# 🚀 One-Click Deployment Guide

Deploy CodeLabs to the cloud in minutes with these step-by-step guides.

## 🎯 Fastest Option: Deploy Everything in 20 Minutes

### Quick Path (Recommended)
1. **Database**: MongoDB Atlas (5 min) - Free forever
2. **Backend**: Railway (10 min) - Free tier available
3. **Frontend**: Vercel (5 min) - Free unlimited deployments

---

## 📱 Step-by-Step: MongoDB Atlas (Database)

### 1. Create Account
- Go to: https://www.mongodb.com/cloud/atlas/register
- Sign up (free account)

### 2. Create Cluster
- Click "Build a Database" → "Free" (M0)
- Choose your region (closest to you)
- Click "Create Cluster"

### 3. Create User
- Go to "Database Access"
- Click "Add New Database User"
- Username: `codelabs_user`
- Password: Click "Autogenerate Secure Password" (save this!)
- User Privileges: "Read and write to any database"
- Click "Add User"

### 4. Allow Access
- Go to "Network Access"
- Click "Add IP Address"
- Click "Allow Access from Anywhere" (for now)
- Confirm

### 5. Get Connection String
- Go to "Database" → Click "Connect"
- Choose "Connect your application"
- Copy the connection string
- Replace `<password>` with your actual password
- Save this string!

Example:
```
mongodb+srv://codelabs_user:YOUR_PASSWORD@cluster0.xxxxx.mongodb.net/?retryWrites=true&w=majority
```

✅ **Done!** You have your database ready.

---

## 🚂 Deploy Backend: Railway (10 Minutes)

### Option 1: Deploy from GitHub (Recommended)

#### 1. Push to GitHub
```bash
cd codelabs-platform
git init
git add .
git commit -m "Initial commit"
git branch -M main
# Create a new repo on GitHub, then:
git remote add origin https://github.com/YOUR_USERNAME/codelabs.git
git push -u origin main
```

#### 2. Connect Railway
- Go to: https://railway.app
- Click "Login" → Sign in with GitHub
- Click "New Project"
- Click "Deploy from GitHub repo"
- Select your `codelabs` repository
- Railway will start deploying automatically!

#### 3. Add Environment Variables
In Railway dashboard:
- Click on your service
- Go to "Variables" tab
- Click "New Variable" and add each:

```
NODE_ENV=production
MONGODB_URI=mongodb+srv://codelabs_user:YOUR_PASSWORD@cluster0.xxxxx.mongodb.net/?retryWrites=true&w=majority
JWT_SECRET=super-secret-key-change-this-to-random-string
CLIENT_URL=https://your-app.vercel.app
```

**Generate secure JWT_SECRET:**
```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

#### 4. Get Your Backend URL
- In Railway, click "Settings" tab
- Under "Domains", click "Generate Domain"
- Copy the URL (e.g., `https://codelabs-production.up.railway.app`)

✅ **Backend is live!**

---

### Option 2: Deploy via CLI

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Initialize project
railway init

# Add environment variables
railway variables set NODE_ENV=production
railway variables set MONGODB_URI="your_connection_string"
railway variables set JWT_SECRET="your_secret_key"
railway variables set CLIENT_URL="https://your-vercel-app.vercel.app"

# Deploy
railway up
```

---

## ▲ Deploy Frontend: Vercel (5 Minutes)

### Option 1: CLI Deployment (Fastest)

```bash
# Install Vercel CLI
npm install -g vercel

# Create production environment file
cd client
cat > .env.production << EOF
REACT_APP_API_URL=https://your-railway-app.railway.app/api
REACT_APP_SOCKET_URL=https://your-railway-app.railway.app
EOF

# Deploy
vercel --prod
```

Follow the prompts:
- Setup and deploy? **Y**
- Which scope? (Select your account)
- Link to existing project? **N**
- Project name? `codelabs`
- Directory? `./` (just press Enter)
- Override settings? **N**

✅ **Frontend is live!**

---

### Option 2: GitHub + Vercel Dashboard

#### 1. Push to GitHub (if not done already)
```bash
cd codelabs-platform
git init
git add .
git commit -m "Initial commit"
git push
```

#### 2. Import to Vercel
- Go to: https://vercel.com
- Click "Add New" → "Project"
- Import your GitHub repository
- Configure:
  - **Root Directory**: Leave blank or set to `client`
  - **Framework Preset**: Create React App
  - **Build Command**: `npm run build`
  - **Output Directory**: `build`

#### 3. Add Environment Variables
In Vercel dashboard:
- Go to "Settings" → "Environment Variables"
- Add:
  ```
  REACT_APP_API_URL = https://your-railway-app.railway.app/api
  REACT_APP_SOCKET_URL = https://your-railway-app.railway.app
  ```

#### 4. Deploy
- Click "Deploy"
- Wait for build to complete
- Click on the deployment URL

✅ **You're live on Vercel!**

---

## 🔗 Connect Everything

### 1. Update Backend with Frontend URL

Go to Railway → Variables → Edit:
```
CLIENT_URL=https://your-app.vercel.app
```

Redeploy backend (Railway auto-redeploys on variable change)

### 2. Test Your Deployment

1. Open your Vercel URL: `https://your-app.vercel.app`
2. Create an account
3. Login
4. Create a room
5. Join a room
6. Test real-time features

---

## 🎨 Alternative: Netlify (Frontend)

If you prefer Netlify over Vercel:

### Deploy via CLI
```bash
# Install Netlify CLI
npm install -g netlify-cli

# Login
netlify login

# Build
cd client
npm run build

# Deploy
netlify deploy --prod --dir=build
```

### Deploy via Drag & Drop
1. Build your app: `cd client && npm run build`
2. Go to: https://app.netlify.com/drop
3. Drag the `build` folder
4. Add environment variables in Netlify dashboard

---

## 🐳 Docker Deployment (Advanced)

For deploying with Docker:

```bash
# Build image
docker build -t codelabs .

# Run container
docker run -p 5000:5000 \
  -e MONGODB_URI="your_connection_string" \
  -e JWT_SECRET="your_secret" \
  -e CLIENT_URL="https://your-frontend.com" \
  codelabs
```

Or use Docker Compose:
```bash
docker-compose up -d
```

---

## ✅ Post-Deployment Checklist

- [ ] MongoDB Atlas cluster is running
- [ ] Backend deployed and accessible
- [ ] Frontend deployed and accessible
- [ ] Environment variables set correctly
- [ ] Can create an account
- [ ] Can login
- [ ] Can create a room
- [ ] Real-time code sync works
- [ ] Chat works
- [ ] Video/audio controls work
- [ ] Music player works

---

## 🔐 Security Checklist

- [ ] Changed JWT_SECRET to a random string
- [ ] MongoDB password is secure
- [ ] CORS configured with specific origins
- [ ] No .env files committed to Git
- [ ] MongoDB IP whitelist configured
- [ ] HTTPS enabled (automatic on Vercel/Railway)

---

## 📊 Your Deployment URLs

After deployment, you'll have:

- **Frontend**: `https://codelabs.vercel.app`
- **Backend API**: `https://codelabs.railway.app/api`
- **WebSocket**: `wss://codelabs.railway.app`
- **Database**: `cluster0.xxxxx.mongodb.net`

---

## 🎉 You're Live!

Share your deployment:
1. Copy your Vercel URL
2. Share with your team
3. Start collaborating!

---

## 🆘 Having Issues?

### Backend not connecting to MongoDB
```bash
# Test connection string
mongosh "your_connection_string"
```

### Frontend can't reach backend
- Check CORS settings in backend
- Verify environment variables
- Check browser console for errors

### Real-time features not working
- Verify Socket.io URL is correct
- Check WebSocket connection in browser DevTools → Network → WS

---

## 💡 Pro Tips

1. **Custom Domain**: Add custom domain in Vercel/Railway settings
2. **Auto Deploy**: Enable auto-deploy on Git push in Vercel
3. **Environment Variables**: Use Railway/Vercel UI for managing secrets
4. **Monitoring**: Check logs in Railway/Vercel dashboard
5. **Scaling**: Upgrade plans when you get more users

---

**Need help?** Check DEPLOYMENT.md for detailed troubleshooting!

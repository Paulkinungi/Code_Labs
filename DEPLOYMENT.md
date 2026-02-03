# 🚀 CodeLabs - Online Deployment Guide

This guide will walk you through deploying CodeLabs to the cloud so it's accessible online.

## 📋 Deployment Overview

We'll deploy in two parts:
1. **Backend (API + Socket.io)** → Railway, Render, or Heroku
2. **Frontend (React App)** → Vercel or Netlify
3. **Database** → MongoDB Atlas (Free Cloud Database)

---

## 🗄️ Part 1: Set Up MongoDB Atlas (Database)

### Step 1: Create MongoDB Atlas Account
1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas/register)
2. Sign up for a free account
3. Create a new cluster (Free M0 tier)

### Step 2: Configure Database
1. Click **"Connect"** on your cluster
2. Add your IP address (or use `0.0.0.0/0` to allow all IPs)
3. Create a database user with username and password
4. Click **"Choose a connection method"** → **"Connect your application"**
5. Copy the connection string (looks like):
   ```
   mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/?retryWrites=true&w=majority
   ```
6. Replace `<password>` with your actual password
7. Save this connection string - you'll need it!

---

## 🔧 Part 2: Deploy Backend (Recommended: Railway)

### Option A: Railway (Easiest, Free Tier Available)

#### Step 1: Create Railway Account
1. Go to [Railway.app](https://railway.app)
2. Sign up with GitHub

#### Step 2: Deploy Backend
1. Click **"New Project"** → **"Deploy from GitHub repo"**
2. Connect your GitHub account
3. Push your code to GitHub first:
   ```bash
   cd codelabs-platform
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin YOUR_GITHUB_REPO_URL
   git push -u origin main
   ```
4. Select your repository in Railway
5. Railway will auto-detect and deploy

#### Step 3: Configure Environment Variables
In Railway dashboard, go to **Variables** and add:
```
NODE_ENV=production
PORT=5000
MONGODB_URI=your_mongodb_atlas_connection_string
JWT_SECRET=your-super-secret-random-string-change-this
CLIENT_URL=https://your-frontend-url.vercel.app
```

#### Step 4: Get Your Backend URL
- After deployment, Railway gives you a URL like: `https://codelabs-api.up.railway.app`
- Save this URL - you'll need it for frontend!

---

### Option B: Render (Alternative Free Option)

#### Step 1: Create Render Account
1. Go to [Render.com](https://render.com)
2. Sign up with GitHub

#### Step 2: Create Web Service
1. Click **"New +"** → **"Web Service"**
2. Connect your GitHub repository
3. Configure:
   - **Name**: codelabs-api
   - **Environment**: Node
   - **Build Command**: `npm install`
   - **Start Command**: `node server/index.js`
   - **Plan**: Free

#### Step 3: Add Environment Variables
```
NODE_ENV=production
MONGODB_URI=your_mongodb_atlas_connection_string
JWT_SECRET=your-super-secret-random-string
CLIENT_URL=https://your-frontend-url.vercel.app
```

#### Step 4: Deploy
- Click **"Create Web Service"**
- Render will build and deploy automatically
- Your URL will be: `https://codelabs-api.onrender.com`

---

### Option C: Heroku

#### Step 1: Install Heroku CLI
```bash
npm install -g heroku
heroku login
```

#### Step 2: Create Heroku App
```bash
cd codelabs-platform
heroku create codelabs-api
```

#### Step 3: Set Environment Variables
```bash
heroku config:set NODE_ENV=production
heroku config:set MONGODB_URI="your_mongodb_atlas_connection_string"
heroku config:set JWT_SECRET="your-secret-key"
heroku config:set CLIENT_URL="https://your-app.vercel.app"
```

#### Step 4: Deploy
```bash
git push heroku main
```

Your app will be at: `https://codelabs-api.herokuapp.com`

---

## 🎨 Part 3: Deploy Frontend

### Option A: Vercel (Recommended)

#### Step 1: Install Vercel CLI
```bash
npm install -g vercel
```

#### Step 2: Configure Environment Variables
Create `client/.env.production`:
```env
REACT_APP_API_URL=https://your-backend-url.railway.app/api
REACT_APP_SOCKET_URL=https://your-backend-url.railway.app
```

#### Step 3: Deploy
```bash
cd client
vercel --prod
```

#### Or Deploy via Vercel Dashboard:
1. Go to [Vercel.com](https://vercel.com)
2. Click **"Import Project"**
3. Import your GitHub repository
4. Set **Root Directory** to `client`
5. Add environment variables in Vercel dashboard
6. Deploy!

Your app will be at: `https://codelabs.vercel.app`

---

### Option B: Netlify

#### Step 1: Install Netlify CLI
```bash
npm install -g netlify-cli
```

#### Step 2: Build the App
```bash
cd client
npm run build
```

#### Step 3: Deploy
```bash
netlify deploy --prod --dir=build
```

#### Or Deploy via Netlify Dashboard:
1. Go to [Netlify.com](https://netlify.com)
2. Drag and drop your `client/build` folder
3. Or connect GitHub repository
4. Set build settings:
   - **Base directory**: `client`
   - **Build command**: `npm run build`
   - **Publish directory**: `client/build`
5. Add environment variables in Netlify dashboard
6. Deploy!

---

## 🔗 Part 4: Connect Frontend to Backend

### Update Backend CORS
Make sure your backend allows requests from your frontend domain:

In `server/index.js`, update CORS:
```javascript
const io = socketIo(server, {
  cors: {
    origin: [
      'http://localhost:3000',
      'https://your-app.vercel.app',
      'https://your-app.netlify.app'
    ],
    methods: ['GET', 'POST'],
    credentials: true
  }
});

app.use(cors({
  origin: [
    'http://localhost:3000',
    'https://your-app.vercel.app',
    'https://your-app.netlify.app'
  ]
}));
```

Redeploy backend after this change.

---

## ✅ Verification Checklist

After deployment, verify everything works:

- [ ] MongoDB Atlas cluster is running
- [ ] Backend is deployed and running
- [ ] Frontend is deployed
- [ ] Can access frontend URL in browser
- [ ] Can create an account (tests DB connection)
- [ ] Can login (tests JWT)
- [ ] Can create a room (tests API)
- [ ] Can join a room (tests Socket.io)
- [ ] Real-time features work (code sync, chat)

---

## 🎯 Quick Deploy Summary

### For the Fastest Deployment:

1. **Database**: MongoDB Atlas (5 minutes)
2. **Backend**: Railway (10 minutes)
   - Push to GitHub
   - Connect to Railway
   - Add environment variables
   - Auto-deploys!

3. **Frontend**: Vercel (5 minutes)
   - Run `vercel --prod` from client folder
   - Or connect GitHub to Vercel
   - Auto-deploys!

**Total Time: ~20 minutes**

---

## 🔐 Important Security Notes

1. **Never commit `.env` files** to Git
2. Use strong, random JWT secrets:
   ```bash
   node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
   ```
3. In MongoDB Atlas, restrict IP addresses in production
4. Use environment variables for all secrets
5. Enable HTTPS (automatic on Vercel/Netlify/Railway)

---

## 🐛 Troubleshooting

### Backend won't start
- Check environment variables are set correctly
- Check MongoDB connection string is valid
- Look at deployment logs in Railway/Render dashboard

### Frontend can't connect to backend
- Verify REACT_APP_API_URL and REACT_APP_SOCKET_URL are correct
- Check CORS is configured properly
- Ensure backend URL uses HTTPS

### Socket.io not connecting
- Verify SOCKET_URL in frontend matches backend URL
- Check browser console for errors
- Ensure backend allows WebSocket connections

### Database connection failed
- Double-check MongoDB Atlas connection string
- Verify password has no special characters that need encoding
- Check IP whitelist in MongoDB Atlas (use `0.0.0.0/0` for testing)

---

## 💰 Cost Breakdown

### Free Tier (Recommended for Testing)
- **MongoDB Atlas**: Free (M0 cluster, 512MB)
- **Railway**: Free tier with 500 hours/month
- **Vercel**: Free tier (unlimited deployments)
- **Total**: $0/month

### Paid Options (For Production)
- **MongoDB Atlas**: $9/month (M10 cluster)
- **Railway**: $5/month (Hobby plan)
- **Vercel**: Free (Pro is $20/month if needed)
- **Total**: ~$14-34/month

---

## 🎊 You're Live!

Once deployed, your CodeLabs platform will be accessible at:
- **Frontend**: `https://your-app.vercel.app`
- **Backend API**: `https://your-api.railway.app`

Share your URL with team members and start collaborating!

---

## 📞 Need Help?

If you run into issues:
1. Check deployment logs in your hosting platform
2. Verify all environment variables are set
3. Test backend API endpoints with Postman
4. Check browser console for frontend errors

Happy deploying! 🚀

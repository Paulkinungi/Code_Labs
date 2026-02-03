# ✅ CodeLabs Deployment Checklist

Follow these steps in order for a successful deployment.

## 🎯 20-Minute Deployment Path

### Step 1: Database Setup (5 minutes)
- [ ] Go to https://mongodb.com/cloud/atlas
- [ ] Create free account
- [ ] Create M0 Free cluster
- [ ] Create database user
- [ ] Allow access from anywhere (0.0.0.0/0)
- [ ] Copy connection string
- [ ] Save connection string securely

**Connection String Format:**
```
mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/
```

---

### Step 2: Push to GitHub (2 minutes)
```bash
cd codelabs-platform
git init
git add .
git commit -m "Initial commit"
git branch -M main
# Create repo on GitHub first, then:
git remote add origin https://github.com/YOUR_USERNAME/codelabs.git
git push -u origin main
```

- [ ] Code pushed to GitHub
- [ ] Repository is public or connected to Railway/Vercel

---

### Step 3: Deploy Backend - Railway (8 minutes)
- [ ] Go to https://railway.app
- [ ] Sign up with GitHub
- [ ] Click "New Project" → "Deploy from GitHub repo"
- [ ] Select your repository
- [ ] Wait for initial deploy

**Add Environment Variables:**
- [ ] NODE_ENV = `production`
- [ ] MONGODB_URI = `your_mongodb_connection_string`
- [ ] JWT_SECRET = `random_string_here` (use: `openssl rand -hex 32`)
- [ ] CLIENT_URL = `https://your-app.vercel.app` (update later)

**Get Backend URL:**
- [ ] Click Settings → Domains → Generate Domain
- [ ] Copy URL (e.g., `https://codelabs.up.railway.app`)
- [ ] Save for next step

---

### Step 4: Deploy Frontend - Vercel (5 minutes)

**Option A: CLI (Fastest)**
```bash
cd client

# Create production env file
echo "REACT_APP_API_URL=https://YOUR_RAILWAY_URL/api" > .env.production
echo "REACT_APP_SOCKET_URL=https://YOUR_RAILWAY_URL" >> .env.production

# Install Vercel CLI
npm install -g vercel

# Deploy
vercel --prod
```

**Option B: Dashboard**
- [ ] Go to https://vercel.com
- [ ] Import GitHub repository
- [ ] Set Root Directory to `client`
- [ ] Add environment variables:
  - REACT_APP_API_URL = `https://YOUR_RAILWAY_URL/api`
  - REACT_APP_SOCKET_URL = `https://YOUR_RAILWAY_URL`
- [ ] Deploy

**Get Frontend URL:**
- [ ] Copy Vercel deployment URL
- [ ] Save this URL

---

### Step 5: Final Configuration (2 minutes)

**Update Backend with Frontend URL:**
- [ ] Go back to Railway
- [ ] Update CLIENT_URL variable to your Vercel URL
- [ ] Wait for auto-redeploy

**Test Everything:**
- [ ] Open your Vercel URL
- [ ] Create an account
- [ ] Login works
- [ ] Create a room
- [ ] Join room works
- [ ] Code editor syncs
- [ ] Chat works
- [ ] No console errors

---

## 🎊 Success!

Your CodeLabs platform is now live at:
- **Frontend**: https://your-app.vercel.app
- **Backend**: https://your-api.railway.app

---

## 📝 Important Notes

### Security
- ✅ Never commit .env files
- ✅ Use strong random JWT_SECRET
- ✅ Keep MongoDB credentials secure
- ✅ Enable HTTPS (automatic on Vercel/Railway)

### Cost
- **MongoDB Atlas**: Free (M0 Cluster)
- **Railway**: Free tier with 500 hours/month
- **Vercel**: Free unlimited deployments
- **Total**: $0/month

### Scaling
When you get more users:
- Upgrade MongoDB to M10 ($9/month)
- Upgrade Railway to Hobby ($5/month)
- Keep Vercel free (or Pro at $20/month if needed)

---

## 🐛 Quick Troubleshooting

### Can't connect to MongoDB
```bash
# Test your connection string
mongosh "YOUR_CONNECTION_STRING"
```

### Backend won't start
- Check Railway logs
- Verify all environment variables are set
- Check MongoDB connection string

### Frontend can't reach backend
- Verify REACT_APP_API_URL is correct
- Check CORS settings in backend
- Look at browser console for errors

### Socket.io not working
- Verify REACT_APP_SOCKET_URL matches backend
- Check WebSocket in browser DevTools

---

## 🆘 Need Help?

1. Check deployment logs in Railway/Vercel
2. Read DEPLOYMENT.md for detailed guide
3. Read QUICK_DEPLOY.md for step-by-step instructions
4. Check browser console for frontend errors
5. Check Railway logs for backend errors

---

## 🚀 Next Steps

After deployment:
1. ✅ Test all features thoroughly
2. ✅ Add custom domain (optional)
3. ✅ Set up monitoring
4. ✅ Enable analytics
5. ✅ Share with your team!

---

**Deployment Time**: ~20 minutes
**Cost**: Free
**Difficulty**: Easy ⭐⭐☆☆☆

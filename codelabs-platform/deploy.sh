#!/bin/bash

# CodeLabs Automated Deployment Script
# This script helps you deploy CodeLabs to the cloud quickly

echo "🚀 CodeLabs Deployment Assistant"
echo "================================"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install git first."
    exit 1
fi

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo "📦 Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit for CodeLabs platform"
    echo "✅ Git repository initialized"
else
    echo "✅ Git repository already exists"
fi

echo ""
echo "Choose your deployment platform:"
echo "1) Railway (Recommended - Easiest)"
echo "2) Render"
echo "3) Vercel (Frontend only)"
echo "4) Manual setup instructions"
echo ""
read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        echo ""
        echo "🚂 Railway Deployment"
        echo "===================="
        echo ""
        echo "Steps:"
        echo "1. Go to https://railway.app and sign up with GitHub"
        echo "2. Click 'New Project' → 'Deploy from GitHub repo'"
        echo "3. Connect this repository"
        echo "4. Add these environment variables in Railway:"
        echo ""
        echo "   NODE_ENV=production"
        echo "   MONGODB_URI=<your-mongodb-atlas-uri>"
        echo "   JWT_SECRET=$(node -e "console.log(require('crypto').randomBytes(32).toString('hex'))")"
        echo "   CLIENT_URL=<your-vercel-url>"
        echo ""
        echo "5. Railway will auto-deploy your backend!"
        echo ""
        echo "📝 Don't forget to deploy frontend to Vercel separately"
        ;;
    2)
        echo ""
        echo "🎨 Render Deployment"
        echo "===================="
        echo ""
        echo "Steps:"
        echo "1. Go to https://render.com and sign up"
        echo "2. Click 'New +' → 'Web Service'"
        echo "3. Connect your GitHub repository"
        echo "4. Configure:"
        echo "   - Environment: Node"
        echo "   - Build Command: npm install"
        echo "   - Start Command: node server/index.js"
        echo ""
        echo "5. Add environment variables:"
        echo "   NODE_ENV=production"
        echo "   MONGODB_URI=<your-mongodb-atlas-uri>"
        echo "   JWT_SECRET=$(node -e "console.log(require('crypto').randomBytes(32).toString('hex'))")"
        echo "   CLIENT_URL=<your-vercel-url>"
        echo ""
        ;;
    3)
        echo ""
        echo "▲ Vercel Deployment (Frontend)"
        echo "=============================="
        echo ""
        if ! command -v vercel &> /dev/null; then
            echo "Installing Vercel CLI..."
            npm install -g vercel
        fi
        echo ""
        echo "Creating production environment file..."
        read -p "Enter your backend URL (e.g., https://api.railway.app): " backend_url
        
        cat > client/.env.production << EOF
REACT_APP_API_URL=${backend_url}/api
REACT_APP_SOCKET_URL=${backend_url}
EOF
        
        echo "✅ Environment file created"
        echo ""
        echo "Deploying to Vercel..."
        cd client
        vercel --prod
        ;;
    4)
        echo ""
        echo "📚 Manual Setup Instructions"
        echo "==========================="
        echo ""
        echo "Please read DEPLOYMENT.md for detailed step-by-step instructions"
        echo ""
        ;;
    *)
        echo "Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo ""
echo "🔐 Security Reminder:"
echo "- Never commit .env files to Git"
echo "- Use strong random strings for JWT_SECRET"
echo "- Configure CORS properly in production"
echo ""
echo "📖 For detailed instructions, see DEPLOYMENT.md"
echo ""
echo "✨ Good luck with your deployment!"

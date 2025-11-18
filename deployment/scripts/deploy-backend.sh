#!/bin/bash

# Backend Deployment Script
# Usage: ./deployment/scripts/deploy-backend.sh [render|heroku|railway]

set -e

PLATFORM=${1:-render}
echo "🚀 Deploying backend to $PLATFORM..."

case $PLATFORM in
  "render")
    echo "📦 Preparing for Render deployment..."
    # Render uses git-based deployment, just ensure we're on main branch
    git checkout main
    git add .
    git commit -m "Deploy backend to Render" || echo "No changes to commit"
    git push origin main
    echo "✅ Backend deployment triggered to Render"
    ;;

  "heroku")
    echo "📦 Preparing for Heroku deployment..."
    # Check if Heroku CLI is installed
    if ! command -v heroku &> /dev/null; then
        echo "❌ Heroku CLI not found. Please install it first."
        exit 1
    fi

    # Login to Heroku
    heroku login

    # Create app if it doesn't exist
    APP_NAME=${HEROKU_APP_NAME:-"mern-chat-app-$(date +%s)"}
    heroku create $APP_NAME || echo "App already exists"

    # Set environment variables
    heroku config:set NODE_ENV=production -a $APP_NAME
    heroku config:set MONGODB_URI=$MONGODB_URI -a $APP_NAME
    heroku config:set JWT_SECRET=$JWT_SECRET -a $APP_NAME
    heroku config:set CLIENT_URL=$CLIENT_URL -a $APP_NAME

    # Deploy
    heroku buildpacks:set heroku/nodejs -a $APP_NAME
    git subtree push --prefix server heroku main
    echo "✅ Backend deployed to Heroku at https://$APP_NAME.herokuapp.com"
    ;;

  "railway")
    echo "📦 Preparing for Railway deployment..."
    # Check if Railway CLI is installed
    if ! command -v railway &> /dev/null; then
        echo "❌ Railway CLI not found. Please install it first."
        exit 1
    fi

    # Login to Railway
    railway login

    # Deploy
    cd server
    railway up
    echo "✅ Backend deployed to Railway"
    ;;

  *)
    echo "❌ Unsupported platform: $PLATFORM"
    echo "Supported platforms: render, heroku, railway"
    exit 1
    ;;
esac

echo "🎉 Backend deployment complete!"
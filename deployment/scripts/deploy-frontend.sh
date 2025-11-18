#!/bin/bash

# Frontend Deployment Script
# Usage: ./deployment/scripts/deploy-frontend.sh [vercel|netlify|github-pages]

set -e

PLATFORM=${1:-vercel}
echo "🚀 Deploying frontend to $PLATFORM..."

case $PLATFORM in
  "vercel")
    echo "📦 Preparing for Vercel deployment..."
    # Check if Vercel CLI is installed
    if ! command -v vercel &> /dev/null; then
        echo "❌ Vercel CLI not found. Please install it first."
        exit 1
    fi

    # Deploy
    cd client
    vercel --prod
    echo "✅ Frontend deployed to Vercel"
    ;;

  "netlify")
    echo "📦 Preparing for Netlify deployment..."
    # Check if Netlify CLI is installed
    if ! command -v netlify &> /dev/null; then
        echo "❌ Netlify CLI not found. Please install it first."
        exit 1
    fi

    # Build the application
    cd client
    npm run build

    # Deploy
    netlify deploy --prod --dir=dist
    echo "✅ Frontend deployed to Netlify"
    ;;

  "github-pages")
    echo "📦 Preparing for GitHub Pages deployment..."

    # Build the application
    cd client

    # Update vite config for GitHub Pages
    cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  base: '/deployment-and-devops-essentials-Marci-design/',
  build: {
    outDir: 'dist',
    assetsDir: 'assets'
  }
})
EOF

    # Build
    npm run build

    # Deploy to GitHub Pages
    cd ..
    git add client/dist/
    git commit -m "Deploy frontend to GitHub Pages" || echo "No changes to commit"
    git subtree push --prefix client/dist origin gh-pages
    echo "✅ Frontend deployed to GitHub Pages"
    ;;

  *)
    echo "❌ Unsupported platform: $PLATFORM"
    echo "Supported platforms: vercel, netlify, github-pages"
    exit 1
    ;;
esac

echo "🎉 Frontend deployment complete!"
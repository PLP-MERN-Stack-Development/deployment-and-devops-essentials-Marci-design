#  Mth responsive design

##  Deployment

###  Prerequisites
- Node.js 18+
- MongoDB Atlas account
- Deployment platform accounts (Render/Vercel/Heroku/Netlify)
- GitHub account

###  Setup Instructions

#### 1. Clone and Install Dependencies
```bash
git clone <your-repo-url>
cd deployment-and-devops-essentials-Marci-design

# Install server dependencies
cd server
npm install

# Install client dependencies
cd ../client
npm install
```

#### 2. Environment Configuration
```bash
# Server environment variables
cp server/.env.example server/.env
# Edit server/.env with your actual values

# Client environment variables
cp client/.env.example client/.env
# Edit client/.env with your actual values
```

#### 3. Local Development
```bash
# Start backend (terminal 1)
cd server
npm run dev

# Start frontend (terminal 2)
cd client
npm run dev
```

###  Production Deployment

#### Backend Deployment Options
Choose one of the following platforms:

**Render (Recommended)**
```bash
./deployment/scripts/deploy-backend.sh render
```

**Heroku**
```bash
./deployment/scripts/deploy-backend.sh heroku
```

**Railway**
```bash
./deployment/scripts/deploy-backend.sh railway
```

#### Frontend Deployment Options

**Vercel (Recommended)**
```bash
./deployment/scripts/deploy-frontend.sh vercel
```

**Netlify**
```bash
./deployment/scripts/deploy-frontend.sh netlify
```

**GitHub Pages**
```bash
./deployment/scripts/deploy-frontend.sh github-pages
```

##  CI/CD Pipeline

### GitHub Actions Workflows

The repository includes automated CI/CD pipelines:

- **Backend CI**: `.github/workflows/backend-ci.yml`
  - Runs tests and linting on server code
  - Triggers on server changes

- **Frontend CI**: `.github/workflows/frontend-ci.yml`
  - Runs tests, linting, and build on client code
  - Triggers on client changes

- **Backend CD**: `.github/workflows/backend-cd.yml`
  - Auto-deploys backend to Render/Heroku on main branch
  - Configurable environment variables

- **Frontend CD**: `.github/workflows/frontend-cd.yml`
  - Auto-deploys frontend to Vercel/Netlify on main branch
  - Production environment configuration

### Required GitHub Secrets
```
# Backend
MONGODB_URI=mongodb+srv://...
JWT_SECRET=your-jwt-secret
CLIENT_URL=https://your-frontend-domain.vercel.app

# Frontend
VERCEL_TOKEN=your-vercel-token
VERCEL_ORG_ID=your-org-id
VERCEL_PROJECT_ID=your-project-id

# Optional (Heroku)
HEROKU_API_KEY=your-heroku-api-key
HEROKU_APP_NAME=your-app-name
HEROKU_EMAIL=your-email
```

##  Monitoring

### Health Checks
```bash
# Run health check script
node monitoring/health-check.js

# With environment variables
BACKEND_URL=https://your-backend.onrender.com FRONTEND_URL=https://your-frontend.vercel.app node monitoring/health-check.js
```

##  Project Structure

```
├── server/                 # Express.js backend
│   ├── controllers/        # Route controllers
│   ├── models/            # MongoDB models
│   ├── routes/            # API routes
│   ├── socket/            # Socket.io handlers
│   ├── config/            # Database configuration
│   └── scripts/           # Database scripts
├── client/                 # React frontend
│   ├── src/
│   │   ├── components/    # React components
│   │   ├── services/      # API services
│   │   ├── socket/         # Socket.io client
│   │   └── context/       # React context
│   └── public/
├── .github/workflows/      # CI/CD pipelines
├── deployment/             # Deployment scripts
├── server/.env.example     # Server environment template
├── client/.env.example     # Client environment template
└── README.md
```

##  Available Scripts

### Server
```bash
npm start          # Start production server
npm run dev        # Start development server with nodemon
npm test           # Run tests
```

### Client
```bash
npm run dev        # Start development server
npm run build      # Build for production
npm run preview    # Preview production build
npm run lint       # Run ESLint
npm test           # Run tests
```

##  Environment Variables

### Server (.env)
```bash
PORT=5000
NODE_ENV=production
MONGODB_URI=mongodb+srv://...
JWT_SECRET=your-super-secret-jwt-key
CLIENT_URL=https://your-frontend-domain.vercel.app
```

### Client (.env)
```bash
VITE_API_URL=https://your-backend-domain.onrender.com
VITE_SOCKET_URL=https://your-backend-domain.onrender.com
```

##  Performance Optimizations

- **Code Splitting**: Automatic chunk splitting in Vite
- **Caching**: Proper caching headers configured
- **Compression**: Built-in compression in production
- **Image Optimization**: Lazy loading and optimized assets
- **Bundle Analysis**: Source maps enabled for debugging

##  Security Features

- **CORS**: Configured for production domains
- **Security Headers**: XSS protection, content type options
- **JWT Authentication**: Secure token-based authentication
- **Input Validation**: Request payload validation
- **Rate Limiting**: API rate limiting (recommended)

##  Troubleshooting

### Common Issues

1. **Socket Connection Issues**
   - Check CORS configuration
   - Verify environment variables
   - Ensure WebSocket support on hosting platform

2. **Build Failures**
   - Clear node_modules and reinstall
   - Check Node.js version compatibility
   - Verify all environment variables are set

3. **Database Connection**
   - Check MongoDB Atlas IP whitelist
   - Verify connection string format
   - Ensure database user permissions

## Support

For deployment issues:
1. Check the GitHub Actions logs
2. Review the deployment script outputs
3. Verify environment variable configurations
4. Check platform-specific documentation

---

 ##  Assignment Requirements Met:
-  Production-ready MERN application
-  CI/CD pipelines with GitHub Actions
-  Multiple deployment platform options
-  Monitoring and health checks
-  Security configurations
-  Environment variable management
-  Documentation and deployment guides

## Requirements

- A completed MERN stack application from previous weeks
- Accounts on the following services:
  - GitHub
  - MongoDB Atlas
  - Render, Railway, or Heroku (for backend)
  - Vercel, Netlify, or GitHub Pages (for frontend)
- Basic understanding of CI/CD concepts

## Deployment Platforms

### Backend Deployment Options
- **Render**: Easy to use, free tier available
- **Railway**: Developer-friendly, generous free tier
- **Heroku**: Well-established, extensive documentation

### Frontend Deployment Options
- **Vercel**: Optimized for React apps, easy integration
- **Netlify**: Great for static sites, good CI/CD
- **GitHub Pages**: Free, integrated with GitHub

## CI/CD Pipeline

The assignment includes templates for setting up GitHub Actions workflows:
- `frontend-ci.yml`: Tests and builds the React application
- `backend-ci.yml`: Tests the Express.js backend
- `frontend-cd.yml`: Deploys the frontend to your chosen platform
- `backend-cd.yml`: Deploys the backend to your chosen platform
ERN Chat Application - Deployment and DevOps

A real-time chat application built with the MERN stack (MongoDB, Express.js, React, Node.js) with Socket.io, featuring deployment configurations and CI/CD pipelines.

##  Application Features

- **Real-time Messaging**: Instant chat with Socket.io
- **User Authentication**: JWT-based login/registration
- **Room Management**: Create and join chat rooms
- **File Sharing**: Upload and share files
- **Typing Indicators**: See when others are typing
- **Responsive Design**: Works on desktop and mobile

##  Tech Stack

### Backend
- **Node.js** with Express.js 5.1.0
- **Socket.io** 4.8.1 for real-time communication
- **MongoDB** with Mongoose 8.19.3
- **JWT** for authentication
- **Multer** for file uploads

### Frontend
- **React** 19.2.0 with Vite 7.2.2
- **Socket.io-client** for real-time communication
- **Axios** for HTTP requests
- **Modern CSS** w
#!/usr/bin/env bash
set -e

ROOT_DIR="NFD-FULL"

# Create main folders
mkdir -p "$ROOT_DIR/backend/src" "$ROOT_DIR/nfd-frontend/src" "$ROOT_DIR/socket"

########################
# Backend configuration
########################

cat > "$ROOT_DIR/backend/package.json" <<'JSON'
{
  "name": "backend",
  "version": "1.0.0",
  "main": "index.js",
  "type": "module",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "start": "node index.js",
    "postinstall": "npx prisma generate",
    "start:custom": "console-ninja node --env-file .env --watch index.js",
    "sync-front-env": "node scripts/sync-front-env.js",
    "dev": "nodemon src/index.js",
    "prisma": "prisma",
    "generate": "prisma generate",
    "studio": "prisma studio",
    "prisma:push": "prisma db push"
  },
  "dependencies": {
    "@prisma/client": "^6.16.2",
    "@react-oauth/google": "^0.12.2",
    "axios": "^1.10.0",
    "bcryptjs": "^3.0.2",
    "cookie-parser": "^1.4.7",
    "cors": "^2.8.5",
    "dotenv": "^16.6.1",
    "express": "^5.1.0",
    "express-rate-limit": "^7.5.1",
    "express-validator": "^7.2.1",
    "geoip-lite": "^1.4.10",
    "glob": "^10.3.10",
    "google-auth-library": "^10.1.0",
    "helmet": "^8.1.0",
    "hpp": "^0.2.3",
    "ipinfo": "^1.5.2",
    "jsonwebtoken": "^9.0.2",
    "lru-cache": "^10.4.3",
    "multer": "^2.0.1",
    "node-localstorage": "^3.0.5",
    "nodemon": "^3.1.10",
    "openai": "^5.8.2",
    "paseto": "^3.1.4",
    "passport": "^0.7.0",
    "passport-facebook": "^3.0.0",
    "passport-google-oauth20": "^2.0.0",
    "pg": "^8.16.3",
    "rate-limiter-flexible": "^7.1.1",
    "rimraf": "^5.0.10",
    "sanitize-html": "^2.17.0",
    "sjcl": "^1.0.8",
    "socket.io": "^4.8.1",
    "stripe": "^18.2.1"
  },
  "devDependencies": {
    "prisma": "^6.16.2",
    "sass": "^1.92.1"
  }
}
JSON

# Add minimal Prisma schema so `prisma generate` can run during postinstall
mkdir -p "$ROOT_DIR/backend/prisma"
cat > "$ROOT_DIR/backend/prisma/schema.prisma" <<'PRISMA'
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "sqlite"
  url      = "file:./dev.db"
}
PRISMA

# Basic Express server
cat > "$ROOT_DIR/backend/src/index.js" <<'JS'
import express from 'express';
const app = express();
const PORT = process.env.PORT || 5000;

app.get('/', (req, res) => {
  res.send('Backend server is running');
});

app.listen(PORT, () => {
  console.log(`Backend listening on port ${PORT}`);
});
JS

# Install backend dependencies
(
  cd "$ROOT_DIR/backend"
  npm install
)

########################
# Frontend configuration
########################

cat > "$ROOT_DIR/nfd-frontend/package.json" <<'JSON'
{
  "name": "nfd-frontend",
  "private": true,
  "type": "module",
  "engines": {
    "node": ">=18 <21"
  },
  "scripts": {
    "dev": "vite --host",
    "build": "vite build",
    "lint": "eslint .",
    "preview": "vite preview",
    "n-f-d_deploy": "node ./nfd_deploy.cjs"
  },
  "dependencies": {
    "@coreui/icons": "^3.0.1",
    "@coreui/icons-react": "^2.3.0",
    "@coreui/react": "^5.7.0",
    "@react-oauth/google": "^0.12.2",
    "@react-spring/web": "^10.0.1",
    "@reduxjs/toolkit": "^2.8.2",
    "@tailwindcss/vite": "^4.1.11",
    "aos": "^2.3.4",
    "axios": "^1.10.0",
    "bootstrap": "^5.3.7",
    "bulma": "^1.0.4",
    "core-js": "^3.43.0",
    "crypto-js": "^4.2.0",
    "framer-motion": "^12.23.0",
    "gsap": "^3.13.0",
    "i18next": "^25.2.1",
    "i18next-browser-languagedetector": "^8.2.0",
    "js-cookie": "^3.0.5",
    "react": "^18.3.1",
    "react-bootstrap": "^2.10.10",
    "react-dom": "^18.3.1",
    "react-error-boundary": "^6.0.0",
    "react-feather": "^2.0.10",
    "react-haiku": "^2.3.0",
    "react-i18next": "^15.5.3",
    "react-icons": "^5.5.0",
    "react-redux": "^9.2.0",
    "react-router-dom": "^6.30.1",
    "react-toastify": "^11.0.5",
    "timeago.js": "^4.0.2",
    "uuid": "^11.1.0",
    "socket.io-client": "^4.7.2"
  },
  "devDependencies": {
    "@eslint/js": "^9.29.0",
    "@types/react": "^19.1.8",
    "@types/react-dom": "^19.1.6",
    "@vitejs/plugin-react": "^4.6.0",
    "autoprefixer": "^10.4.21",
    "eslint": "^9.29.0",
    "eslint-plugin-react-hooks": "^5.2.0",
    "eslint-plugin-react-refresh": "^0.4.20",
    "globals": "^16.2.0",
    "postcss": "^8.5.6",
    "sass-embedded": "^1.89.2",
    "tailwindcss": "^3.4.17",
    "vite": "^5.4.19"
  }
}
JSON

# Minimal index.html
cat > "$ROOT_DIR/nfd-frontend/index.html" <<'HTML'
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>NFD Frontend</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
HTML

# Minimal React entry
cat > "$ROOT_DIR/nfd-frontend/src/main.jsx" <<'JS'
import React from 'react';
import { createRoot } from 'react-dom/client';

function App() {
  return <div>NFD Frontend is running</div>;
}

const root = createRoot(document.getElementById('root'));
root.render(<App />);
JS

# Vite config
cat > "$ROOT_DIR/nfd-frontend/vite.config.js" <<'JS'
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
});
JS

# Install frontend dependencies
(
  cd "$ROOT_DIR/nfd-frontend"
  npm install
)

########################
# Socket server configuration
########################

cat > "$ROOT_DIR/socket/package.json" <<'JSON'
{
  "name": "socket",
  "version": "1.0.0",
  "main": "app.js",
  "type": "module",
  "dependencies": {
    "axios": "^1.7.3",
    "cors": "^2.8.5",
    "dotenv": "^16.4.7",
    "express": "^4.21.2",
    "http": "^0.0.1-security",
    "socket.io": "^4.8.1",
    "socket.io-client": "^4.8.1"
  }
}
JSON

# Basic socket.io server
cat > "$ROOT_DIR/socket/app.js" <<'JS'
import express from 'express';
import http from 'http';
import { Server } from 'socket.io';
import cors from 'cors';

const app = express();
app.use(cors());

const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: '*',
  },
});

io.on('connection', (socket) => {
  console.log('User connected:', socket.id);
  socket.on('disconnect', () => {
    console.log('User disconnected:', socket.id);
  });
});

const PORT = process.env.PORT || 7000;
server.listen(PORT, () => {
  console.log(`Socket server listening on port ${PORT}`);
});
JS

# Install socket dependencies
(
  cd "$ROOT_DIR/socket"
  npm install
)

# Final messages
echo "✔ Backend ready"
echo "✔ Frontend ready"
echo "✔ Socket server ready"
echo "🎉 All NFD environments installed successfully!"

#!/bin/bash

# ELIA OS Setup Script
# This script helps you set up ELIA OS for development or production

echo ""
echo "███████╗██╗     ██╗ █████╗     ██████╗ ███████╗"
echo "██╔════╝██║     ██║██╔══██╗   ██╔═══██╗██╔════╝"
echo "█████╗  ██║     ██║███████║   ██║   ██║███████╗"
echo "██╔══╝  ██║     ██║██╔══██║   ██║   ██║╚════██║"
echo "███████╗███████╗██║██║  ██║   ╚██████╔╝███████║"
echo "╚══════╝╚══════╝╚═╝╚═╝  ╚═╝    ╚═════╝ ╚══════╝"
echo ""
echo "🔐 ELIA OS Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check Node.js
echo "Checking Node.js installation..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    echo "✓ Node.js $NODE_VERSION installed"
else
    echo "✗ Node.js not found!"
    echo "  Please install Node.js 16+ from: https://nodejs.org/"
    exit 1
fi

# Check npm
echo "Checking npm installation..."
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm -v)
    echo "✓ npm $NPM_VERSION installed"
else
    echo "✗ npm not found!"
    exit 1
fi

echo ""
echo "Installing dependencies..."
npm install

if [ $? -eq 0 ]; then
    echo "✓ Dependencies installed successfully"
else
    echo "✗ Failed to install dependencies"
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✓ Setup Complete!"
echo ""
echo "To start the server:"
echo "  npm start"
echo ""
echo "To run in development mode:"
echo "  npm run dev"
echo ""
echo "Server will be available at:"
echo "  http://localhost:3000"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

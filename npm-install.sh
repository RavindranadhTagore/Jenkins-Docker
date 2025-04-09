#!/bin/bash

echo "📦 Installing Node.js dependencies..."
npm install

if [ $? -eq 0 ]; then
    echo "✅ npm install completed successfully."
else
    echo "❌ npm install failed."
    exit 1
fi

# Use a base image
FROM node:18

# Set the working directory
WORKDIR /app

# Copy all files
COPY . .

# Install dependencies (if Node.js project)
RUN npm install

# Expose the app port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]

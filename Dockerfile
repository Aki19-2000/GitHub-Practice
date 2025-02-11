# Use a base image that supports Node.js
FROM node:16-slim

# Set the working directory in the container
WORKDIR /action

# Copy package.json and package-lock.json (if exists) first
COPY package*.json /action/

# Install the action's dependencies
RUN npm install

# Now, copy the rest of the code (index.js and other files)
COPY . /action

# Define the entry point for the container (this will run when the container starts)
ENTRYPOINT ["node", "/action/index.js"]

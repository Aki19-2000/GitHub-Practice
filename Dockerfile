# Use a base image that supports Node.js (or any other required runtime)
FROM node:16-slim

# Set the working directory in the container
WORKDIR /action

# Copy the local files into the container's /action directory
COPY . /action

# Install the action's dependencies
RUN npm install

# Define the entry point for the container to use the new index2.js file
ENTRYPOINT ["node", "/action/index2.js"]

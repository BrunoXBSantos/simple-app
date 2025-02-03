# Use the Node.js image based on your Node.js version
FROM node:18-alpine

WORKDIR /usr/src/app

COPY package*.json yarn.lock* ./

# Install dependencies using Yarn
RUN yarn install --production --frozen-lockfile

COPY . .

# Expose the port your app listens on
EXPOSE 8080

# Start the application using Yarn in production mode
CMD ["yarn", "start:prod"]

FROM node:22-alpine3.18 as build

# Update package lists and install necessary packages
RUN apk update && apk add --no-cache \
    bash \
    nano

# Set the working directory in the container
WORKDIR /app

# Install Angular CLI globally and update PATH for all users
RUN npm install -g @angular/cli && \
    echo 'export PATH=$PATH:/usr/local/bin' >> /etc/profile

# Ensure Angular CLI works
RUN ng version

# Copy the entrypoint script
COPY docker/front/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint to the script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Copy package.json and package-lock.json
COPY package*.json ./

RUN npm run 

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Build the app
RUN npm run build

# Production stage
FROM nginx:latest

# Copy Nginx config
COPY docker/nginx/nginx.conf /etc/nginx/conf.d/default.conf


# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
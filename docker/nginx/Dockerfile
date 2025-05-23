FROM nginx:alpine

WORKDIR /nginx
# Copy the main nginx.conf
COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf

# Copy the server block configuration
COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
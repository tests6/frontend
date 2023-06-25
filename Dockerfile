# Use a lightweight base image
FROM nginx:alpine

# Copy the index.html file to the default Nginx document root
COPY index.html /usr/share/nginx/html

# Copy the entire js folder to the Nginx document root
COPY js /usr/share/nginx/html/js

# Copy the entire css folder to the Nginx document root
COPY css /usr/share/nginx/html/css

# Expose port 80 to allow incoming traffic
EXPOSE 80

# Start Nginx server when the container is launched
CMD ["nginx", "-g", "daemon off;"]

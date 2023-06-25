# Use a lightweight base image
FROM nginx:alpine

# Set the default IP address to 0.0.0.0
ARG BACKEND_IP=0.0.0.0

# Copy the index.html file to the default Nginx document root
COPY index.html /usr/share/nginx/html

# Copy the entire js folder to the Nginx document root
COPY js /usr/share/nginx/html/js

# Copy the entire css folder to the Nginx document root
COPY css /usr/share/nginx/html/css

# Replace the backend IP address in the JavaScript code using sed
RUN sed -i "s|http://0.0.0.0:8000|http://${BACKEND_IP}:8000|g" /usr/share/nginx/html/js/script.js

# Expose port 80 to allow incoming traffic
EXPOSE 80

# Start Nginx server when the container is launched
CMD ["nginx", "-g", "daemon off;"]

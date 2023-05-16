# Use the latest version of Ubuntu as the base image
FROM ubuntu:latest

# Install Nginx web server
RUN apt-get update && \
    apt-get install -y nginx

# Copy the web application files to the appropriate location
COPY index.html /var/www/html/index.html

# Expose the default HTTP port
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]


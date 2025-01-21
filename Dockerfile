# FROM specifies what base image will be using to build our own image
# Almost every single image is based on other image mostly linux

# base image is from nginx from docker hub
FROM nginx:1.27.3-alpine

# Environment Variables 
# ENV PRODUCTION=true

# COPY src dest
COPY src/html /usr/share/nginx/html

# EXPOSE 80/tcp (default)
# EXPOSE 80/udp


# For entry point 
# Below is the default
# CMD ["nginx", "-g", "daemon off;"]

# For nginx in debug mode
# CMD ["nginx-debug", "-g", "daemon off;"]
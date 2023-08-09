# Set the base image to node:12-alpine
FROM node:18-alpine as build

# Specify where our app will live in the container
WORKDIR /app

# Copy the React App to the container
COPY . /app/

# Prepare the container for building React
RUN yarn install
# We want the production version
RUN yarn build

# Prepare nginx
FROM nginx:1.24.0-alpine
COPY --from=build /app/.next /usr/share/nginx/html
# RUN rm /etc/nginx/conf.d/default.conf
COPY app/nginx.conf /etc/nginx/conf.d/default.conf

# Fire up nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
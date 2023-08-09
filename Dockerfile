# Tahap pertama: Membangun aplikasi Next.js
FROM node:latest AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Tahap kedua: Menjalankan aplikasi dengan Nginx
FROM nginx:alpine

# Salin konfigurasi Nginx kustom ke dalam kontainer
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Salin hasil build dari tahap pertama ke direktori yang sesuai di dalam kontainer Nginx
COPY --from=build /app/.next /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

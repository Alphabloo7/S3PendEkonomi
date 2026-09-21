# Base image Nginx Alpine ultra-ringan (~15 MB)
FROM nginx:alpine

# Install curl untuk Docker healthcheck
RUN apk add --no-cache curl

# Hapus konfigurasi default Nginx
RUN rm -rf /etc/nginx/conf.d/default.conf /usr/share/nginx/html/*

# Salin konfigurasi Nginx kustom
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

# Salin seluruh aset website ke direktori web root Nginx
COPY . /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Healthcheck otomatis
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -fsS http://localhost/healthz || exit 1

CMD ["nginx", "-g", "daemon off;"]

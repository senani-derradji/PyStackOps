FROM nginx:latest

WORKDIR /etc/nginx/
COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/certs
COPY certs /etc/nginx/certs

RUN mkdir -p /var/cache/nginx/my_cache
RUN chown -R www-data:www-data /var/cache/nginx/my_cache
FROM debian:bookworm


RUN apt-get update && apt-get -y install nginx openssl

COPY conf/nginx.conf /etc/nginx/sites-available/default

RUN mkdir -p /var/www/html/wordpress /etc/nginx/ssl && \
    openssl genrsa --out /etc/nginx/ssl/nginx.key 2048 && \
    openssl req -batch -new -key /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.csr && \
    openssl x509 -req -days 365 -in /etc/nginx/ssl/nginx.csr \
    -signkey /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt


EXPOSE 443


CMD ["nginx", "-g", "daemon off;"]

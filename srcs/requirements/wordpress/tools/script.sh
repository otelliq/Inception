#!/bin/bash
mkdir -p /run/php

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar 
mv wp-cli.phar /usr/local/bin/wp

sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|g" /etc/php/8.2/fpm/pool.d/www.conf

mkdir -p /var/www/html/wordpress 

cd /var/www/html/wordpress

if [ ! -f "$WORDPRESS_DIR/wp-config.php" ]; then
  wp core download --allow-root
  wp config create --allow-root  --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST  
  wp core install --allow-root --url="$WEBSITE" --title="Inception" --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASS --admin_email="$ADMIN_EMAIL"  
  wp user create --allow-root $USER $USR_EMAIL --role=editor --user_pass=$USR_PASS 


exec php-fpm8.2 -F
else
  echo "WordPress is already installed."
fi



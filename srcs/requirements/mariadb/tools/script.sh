#!bin/sh


echo $DB_NAME 
echo $DB_USER 
echo $DB_PASSWORD 
echo $DB_HOST 
echo $DOMAIN_NAME 
echo $ADMIN 
echo $PASS 
echo $EMAIL 
echo $WP_TITLE 
echo $WEBSITE 
echo $WP_ADMIN_EMAIL 
echo $WP_ADMIN_USER 
echo $WP_ADMIN_PASS 
echo $USER 
echo $USER_PASS 
echo $USER_MAIL

if [ ! -d "/run/mysqld" ]; then
	mkdir /run/mysqld;
fi
cat << EOF > /sql.sql
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
EOF

mariadbd --user=root --bootstrap < /sql.sql;

exec "$@"
#!/bin/bash

echo "Database initialization"

mysqld &

if ! mysqladmin --wait=30 ping;
then
	printf "Could not ping mariadb for 30 seconds, runtime configuration is not possible.\n"
	exit 1
fi

echo "Building database"

mysql -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -u root -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ROOT_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mysql -u root -e "INSERT INTO ${MYSQL_DATABASE}.wp_users (user_login,user_pass,user_nicename,user_email,user_url,user_registered,user_activation_key,user_status,display_name) VALUES ('${WP_USER}',MD5('${WP_USER_PASSWORD}'),'${WP_USER}','${WP_USER}@42.fr','https://${DOMAIN_NAME}','2021-10-27','',0,'${WP_USER}');"
mysql -u root -e "FLUSH PRIVILEGES;"
mysqladmin -u root password $MYSQL_ROOT_PASSWORD

echo "Database shutdown"
mysqladmin shutdown

echo "Restarting database"
exec mysqld -u root

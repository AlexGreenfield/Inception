#!/bin/bash

# Replace markes with user
sed -i "s/@php_fpm_user@/www-data/g" /etc/php/8.2/fpm/pool.d/www.conf
sed -i "s/@php_fpm_group@/www-data/g" /etc/php/8.2/fpm/pool.d/www.conf

# First of all, let's get our secrets out
SQL_PASSWORD=$(cat /run/secrets/db_password)
SQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

# Ensure PHP runtime dir exists
mkdir -p /run/php

# Go to WordPress directory
cd /var/www/wordpress

# Wait for MariaDB
echo "Checking if MariaDB is reachable..."
while ! printf "" 2>>/dev/null >/dev/tcp/mariadb/3306; do
    echo "Waiting for MariaDB port 3306..."
    sleep 2
done

#echo "Waiting for MariaDB..."
#sleep 10
#until mariadb-admin ping -h"mariadb" -u root -p"${SQL_ROOT_PASSWORD}" --silent; do
    #sleep 2
#done

# Only run setup if not already configured
# Note, wp-config.php is a mount, must be manually resetd
if [ ! -f wp-config.php ]; then

    echo "Creating wp-config.php..."

    wp config create \
        --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --path='/var/www/wordpress'

    echo "Installing WordPress..."

    wp core install \
        --allow-root \
        --url=$WP_URL \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --path='/var/www/wordpress'

    echo "Creating second user..."

    wp user create $WP_USER $WP_USER_EMAIL \
        --user_pass=$WP_USER_PASSWORD \
        --role=author \
        --allow-root
	chown -R www-data:www-data /var/www/wordpress
fi

# Start PHP-FPM
echo "Starting PHP"
exec php-fpm8.2 -F
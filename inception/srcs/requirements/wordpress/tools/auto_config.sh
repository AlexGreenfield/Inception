#!/bin/bash

# First of all, let's get our secrets out
DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

# Ensure PHP runtime dir exists
mkdir -p /run/php

# Go to WordPress directory
cd /var/www/wordpress

# Wait for MariaDB
sleep 10

# Only run setup if not already configured
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
fi

# Start PHP-FPM
exec php-fpm8.2 -F
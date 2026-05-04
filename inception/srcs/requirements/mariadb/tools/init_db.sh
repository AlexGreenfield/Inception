#!/bin/bash

# Load secrets
SQL_PASSWORD=$(cat /run/secrets/db_password)
SQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

echo "Starting MariaDB in bootstrap mode..."

# 1. Start MariaDB with skip-grant-tables to bypass password checks during setup
# This ensures your script can ALWAYS talk to the DB regardless of the password status.
mysqld_safe --skip-grant-tables --skip-networking &

# 2. Wait for it to wake up
until mysqladmin ping -h localhost --silent; do
    echo "Waiting for MariaDB..."
    sleep 1
done

echo "Configuring database..."

# 3. Apply changes (Note: using -u root here)
mysql -u root <<EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

echo "Shutting down bootstrap instance..."
# 4. Kill the background process cleanly
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

# 5. Start MariaDB normally in the FOREGROUND
echo "Starting MariaDB normally..."
exec mysqld_safe
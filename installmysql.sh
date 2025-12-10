#!/bin/bash

# Update system packages
sudo apt update -y
sudo apt upgrade -y

# Install MySQL Server
sudo apt install mysql-server -y

# Start MySQL service
sudo systemctl start mysql
sudo systemctl enable mysql

# Secure MySQL installation


# Log into MySQL and set up the database and user
sudo mysql -u root -pyourrootpassword <<EOF
CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'%' IDENTIFIED BY 'yourpassword';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';
FLUSH PRIVILEGES;
EXIT;
EOF

# Restart MySQL to ensure all settings are applied
sudo systemctl restart mysql

echo "MySQL setup completed. Database 'wordpress' and user 'wpuser' created."

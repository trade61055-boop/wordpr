#!/bin/bash

# Update and install necessary packages
sudo apt update -y
sudo apt upgrade -y
sudo apt install apache2 php libapache2-mod-php php-mysql wget unzip curl -y

# Start Apache2 service
sudo systemctl enable apache2
sudo systemctl start apache2

# Install WordPress
cd /var/www/html
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzvf latest.tar.gz
sudo mv wordpress/* .
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

# Set up MySQL database connection
sudo cp wp-config-sample.php wp-config.php

# Update wp-config.php with DB details
sudo sed -i "s/database_name_here/wordpress/" /var/www/html/wp-config.php
sudo sed -i "s/username_here/wpuser/" /var/www/html/wp-config.php
sudo sed -i "s/password_here/yourpassword/" /var/www/html/wp-config.php
sudo sed -i "s/localhost/192.168.56.11/" /var/www/html/wp-config.php  # DB IP

# Restart Apache2 to apply changes
sudo systemctl restart apache2

echo "Web server setup completed. Access WordPress at http://192.168.56.10"

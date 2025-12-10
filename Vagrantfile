# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"
  config.vm.box_version = "202510.26.0"

  # VM1: Web Server
  config.vm.define "web" do |web|
    web.vm.hostname = "web-server"
    web.vm.network "private_network", type: "static", ip: "192.168.56.10"
    web.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    end

    # Configure VM1 for Web Server
    web.vm.provision "shell", inline: <<-SHELL
      # Update and install Apache, PHP and WordPress dependencies
      sudo su
      sudo apt update
      sudo apt install -y apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip

      # Download and configure WordPress
        sudo mkdir -p /srv/www
        sudo chown www-data: /srv/www
        curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www



      # wget https://wordpress.org/latest.tar.gz
      # tar -xvzf latest.tar.gz
      # sudo cp -R wordpress/* /var/www/html/
      # sudo chown -R www-data:www-data /var/www/html/
      # sudo chmod -R 755 /var/www/html/

      # Enable apache and restart the service
      sudo systemctl enable apache2
      sudo systemctl start apache2
    SHELL
  end


# VM2: Database Server
  config.vm.define "db" do |db|
    db.vm.hostname = "db-server"
    db.vm.network "private_network", type: "static", ip: "192.168.56.11"
    db.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    end

    # Configure VM2 for MySQL Server
    db.vm.provision "shell", inline: <<-SHELL
      # Update and install MySQL Server
      sudo su
      sudo apt update
      sudo apt  install -y mysql-server

      # Create Database and App User
      sudo mysql -u root
      sudo mysql -e "CREATE DATABASE wordpress;"
      # sudo mysql -e "CREATE USER 'wp_user'@'%' IDENTIFIED BY 'password';"
      CREATE USER wordpress@localhost IDENTIFIED BY 'anjan123';
      # sudo mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';"
      GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON wordpress.* TO wordpress@localhost;
      sudo mysql -e "FLUSH PRIVILEGES;"

      # Restart MySQL service
      sudo systemctl enable mysql
      sudo systemctl start mysql
      sudo service mysql start
    SHELL
  end


  
end
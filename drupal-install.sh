
#!/bin/bash -e
clear
echo "============================================"
echo "Installing Pre-Requistes"
echo "============================================"
sudo yum install -y httpd24 php56 mysql55-server php56-mysqlnd php56-mbstring php56-gd 
#php56-opcache
sudo service httpd start
sudo service mysqld start
sudo chkconfig httpd on
sudo chkconfig mysqld on

# configuring the MySQL server

echo "============================================"
echo "Configuring MySQL server"
echo "============================================"

sudo /usr/libexec/mysql55/mysqladmin -u root password 'drupaluser@28june'
# Creating a mysql database
mysql -u root -proot@123 -e "create database drupal_summit; GRANT ALL PRIVILEGES ON drupal_summit.* TO root@localhost IDENTIFIED BY 'drupaluser@28june';FLUSH PRIVILEGES;"

echo "============================================"
echo "Installing Drupal 8.."
echo "============================================"

cd /var/www/html
#download drupal 8
sudo wget http://ftp.drupal.org/files/projects/drupal-8.1.3.tar.gz
#unzip drupal
sudo tar -zxvf drupal-8.1.3.tar.gz
#change dir to drupal
cd drupal-8.1.3
#copy file to parent dir
sudo cp -rf . ..
#move back to parent dir
cd ..
#remove files from drupal-8.1.3 folder
sudo rm -R drupal-8.1.3
#create wp config
cp sites/default/default.settings.php  settings.php
#set set http with perl find and replace
sudo perl -pi -e "s/AllowOverride None/AllowOverride All/g" /etc/httpd/conf/httpd.conf

#restart the httpd server
sudo service httpd restart

#create uploads folder and set permissions
#mkdir wp-content/uploads
chmod 775 wp-content/uploads
#echo "Cleaning..."
#remove zip file
#rm latest.tar.gz
#remove bash script
echo "========================="
echo "Installation is complete."
echo "========================="

echo " Please note your MySQL Root password : drupaluser@28june"

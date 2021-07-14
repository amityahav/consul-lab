   
   #Install Apache
   apt-get update
   apt-get install -y apache2

   #make apache listen on port 8080 -working
   cp /vagrant/000-default.conf /etc/apache2/sites-enabled/000-default.conf
   cp /vagrant/ports.conf /etc/apache2/.

   #custom test-page
   cp /vagrant/index.html /var/www/html/index.html


systemctl restart apache2



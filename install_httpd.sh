#! /bin/bash
sudo yum update -y
sudo yum -y install httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo '<h1><center>Terraform Provisioned Website</center></h1>' > index.html
sudo mv index.html /var/www/html/
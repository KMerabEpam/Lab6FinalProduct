# Create instances

resource "aws_instance" "web_server-1" {
    ami                         = "ami-05d34d340fb1d89e5"
    instance_type               = "t2.micro"
    key_name                    = "web_server_1-keypair"
    associate_public_ip_address = true
    vpc_security_group_ids      = ["${aws_security_group.EC2.id}"]
    subnet_id                   = module.vpc.vpc_id

    provisioner "remote-exec" {
    inline = [
      "sudo yum -y install httpd && sudo systemctl start httpd",
      "echo '<h1><center>Terraform Provisioned Website</center></h1>' > index.html",
      "sudo mv index.html /var/www/html/"
    ]

    # connection {
    #   type        = "ssh"
    #   user        = "ec2-user"
    #   private_key = file("~/.ssh/id_rsa")
    #   host        = 
    # }
  }
  tags = {
    Name = "webserver"
}
}

resource "aws_instance" "web_server-2" {
    ami = "ami-05d34d340fb1d89e5"
    instance_type = "t2.micro"
    key_name                    = "web_server_2-keypair"
    associate_public_ip_address = true
    vpc_security_group_ids      = ["${aws_security_group.EC2.id}"]
    subnet_id                   = module.vpc.vpc_id

    provisioner "remote-exec" {
    inline = [
      "sudo yum -y install httpd && sudo systemctl start httpd",
      "echo '<h1><center>Terraform Provisioned Website</center></h1>' > index.html",
      "sudo mv index.html /var/www/html/"
    ]

    # connection {
    #   type        = "ssh"
    #   user        = "ec2-user"
    #   private_key = file("~/.ssh/id_rsa")
    #   host        = 
    # }
  }
    tags = {
        Name = "web_server-2"
    }
}
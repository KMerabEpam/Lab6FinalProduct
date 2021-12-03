# Create instances

resource "aws_instance" "web_server-1" {
    ami                         = "ami-05d34d340fb1d89e5"
    instance_type               = "t2.micro"
    key_name                    = "web_server_1-keypair"
    associate_public_ip_address = true
    vpc_security_group_ids      = ["${aws_security_group.SSH-HTTP-HTTPS.id}"]
    subnet_id                   = "module.vpc.private_subnets"
    user_data = "${file("install_httpd.sh")}"

    tags = {
        Name = "web_server-1"
    }
}

resource "aws_instance" "web_server-2" {
    ami = "ami-05d34d340fb1d89e5"
    instance_type = "t2.micro"
    key_name                    = "web_server_2-keypair"
    associate_public_ip_address = true
    vpc_security_group_ids      = ["${aws_security_group.SSH-HTTP-HTTPS.id}"]
    subnet_id                   = "module.vpc.private_subnets"
    user_data = "${file("install_httpd.sh")}"

    tags = {
        Name = "web_server-2"
    }
}
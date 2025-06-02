# create an ec2 instance

# where to build this - give cloud provider
# give desired region
provider "aws" {
 region = var.region
 access_key = var.key
 secret_key = var.secret_key
}

data "aws_key_pair" "tech504-callum-aws"{
  key_name = "tech504-callum-laptop-pem"
  include_public_key = true
}

# which resource we actually want
resource "aws_instance" "tech504-callum-jenkins-server" {
    # which image do we use? - on AWS called an AMI for some reason.
    # what is AMI ID? ami-0c1c30571d2dae5c9 (ubuntu 22.04lts)
    ami            = var.app_ami_id    
    # which instance type - t3.micro
    instance_type = "t3.small"//var.machine   
    # do we want a public IP?
    associate_public_ip_address = var.is_public
    vpc_security_group_ids = [aws_security_group.tech504-callum-jenkins-security.id]
    key_name = data.aws_key_pair.tech504-callum-aws.key_name   
    # instance name
    tags = {
        Name = var.name
    }
}

resource "aws_instance" "tech504-callum-jenkins-target" {
    # which image do we use? - on AWS called an AMI for some reason.
    # what is AMI ID? ami-0c1c30571d2dae5c9 (ubuntu 22.04lts)
    ami            = var.app_ami_id    

    # which instance type - t3.micro
    instance_type = var.machine
    
    # do we want a public IP?
    associate_public_ip_address = var.is_public

    vpc_security_group_ids = [data.aws_security_group.app_security.id]

    key_name = data.aws_key_pair.tech504-callum-aws.key_name
    
    # instance name
    tags = {
        Name = "tech504-callum-jenkins-target"
    }
}

data "aws_security_group" "app_security" {
  id = "sg-01afda1f8793d5bd0"
}

# Using Terraform and Terraform official documentation:
# Create an AWS security group named techXXX-firstname-tf-allow-port-22-3000-80 (tf so you know it was created by Terraform)
resource "aws_security_group" "tech504-callum-jenkins-security" {
  name = "tech504-callum-jenkins-security"
  description = "allows ssh and ports 8080, 8443"
  tags = {
    Name = "tech504-callum-jenkins-security"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh" {
  security_group_id = aws_security_group.tech504-callum-jenkins-security.id
  cidr_ipv4         = var.CIDR
  ip_protocol       = "tcp" 
  from_port         = 22
  to_port           = 22
}

#   Allow port 80 from all
resource "aws_vpc_security_group_ingress_rule" "allow-http" {
  security_group_id = aws_security_group.tech504-callum-jenkins-security.id
  cidr_ipv4         = var.CIDR
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}

#   Allow port ??? from all
resource "aws_vpc_security_group_ingress_rule" "allow-tcp-8080" {
  security_group_id = aws_security_group.tech504-callum-jenkins-security.id
  cidr_ipv4         = var.CIDR
  ip_protocol       = "tcp"
  from_port         = 8080
  to_port           = 8080
}

resource "aws_vpc_security_group_ingress_rule" "allow-tcp-8443" {
  security_group_id = aws_security_group.tech504-callum-jenkins-security.id
  cidr_ipv4         = var.CIDR
  ip_protocol       = "tcp"
  from_port         = 8443
  to_port           = 8443
}

resource "aws_vpc_security_group_egress_rule" "allow-all-egress" {
  security_group_id = aws_security_group.tech504-callum-jenkins-security.id
  cidr_ipv4         = var.CIDR
  ip_protocol       = -1
  from_port         = 0
  to_port           = 0
}

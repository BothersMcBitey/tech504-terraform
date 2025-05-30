# create an ec2 instance

# where to build this - give cloud provider
# give desired region
provider "aws" {
 region = var.region
}

data "aws_key_pair" "tech504-callum-aws"{
  key_name = "tech504-callum-aws"
  include_public_key = true
  #key_pair_id = "key-035c0e1c5a585ddd1"
}

output "fingerprint" {
  value = data.aws_key_pair.tech504-callum-aws.fingerprint
}

output "name" {
  value = data.aws_key_pair.tech504-callum-aws.key_name
}

output "id" {
  value = data.aws_key_pair.tech504-callum-aws.id
}

# which resource we actually want
resource "aws_instance" "tech504-callum-ubuntu-2204-ansible-controller" {
    # which image do we use? - on AWS called an AMI for some reason.
    # what is AMI ID? ami-0c1c30571d2dae5c9 (ubuntu 22.04lts)
    ami            = var.app_ami_id    

    # which instance type - t3.micro
    instance_type = var.machine
    
    # do we want a public IP?
    associate_public_ip_address = var.is_public

    vpc_security_group_ids = [aws_security_group.tech504-callum-ansible-ssh-only.id]

    key_name = data.aws_key_pair.tech504-callum-aws.key_name
    
    # instance name
    tags = {
        Name = "tech504-callum-ubuntu-2204-ansible-controller"
    }
}

resource "aws_instance" "tech504-callum-ubuntu-2204-ansible-target-node-app" {
    # which image do we use? - on AWS called an AMI for some reason.
    # what is AMI ID? ami-0c1c30571d2dae5c9 (ubuntu 22.04lts)
    ami            = var.app_ami_id    

    # which instance type - t3.micro
    instance_type = var.machine
    
    # do we want a public IP?
    associate_public_ip_address = var.is_public

    vpc_security_group_ids = [aws_security_group.tech504-callum-ansible-ssh-http-3000.id]

    key_name = data.aws_key_pair.tech504-callum-aws.key_name
    
    # instance name
    tags = {
        Name = "tech504-callum-ubuntu-2204-ansible-target-node-app"
    }
}

resource "aws_instance" "tech504-callum-ubuntu-2204-ansible-target-node-database" {
    # which image do we use? - on AWS called an AMI for some reason.
    # what is AMI ID? ami-0c1c30571d2dae5c9 (ubuntu 22.04lts)
    ami            = var.app_ami_id    

    # which instance type - t3.micro
    instance_type = var.machine
    
    # do we want a public IP?
    associate_public_ip_address = false

    vpc_security_group_ids = [aws_security_group.tech504-callum-ansible-db-rules.id]

    key_name = data.aws_key_pair.tech504-callum-aws.key_name
    
    # instance name
    tags = {
        Name = "tech504-callum-ubuntu-2204-ansible-target-node-database"
    }
}

# Using Terraform and Terraform official documentation:
# Create an AWS security group named techXXX-firstname-tf-allow-port-22-3000-80 (tf so you know it was created by Terraform)
resource "aws_security_group" "tech504-callum-ansible-ssh-only" {

  name = "tech504-callum-ansible-ssh-only"
  description = "allows ssh"

  tags = {
    Name = "tech504-callum-tf-allow-port-22"
  }
}

resource "aws_security_group" "tech504-callum-ansible-ssh-http-3000" {

  name = "tech504-callum-ansible-ssh-http-3000"
  description = "allows ssh"

  tags = {
    Name = "tech504-callum-tf-allow-port-22-http-3000"
  }
}

resource "aws_security_group" "tech504-callum-ansible-db-rules" {

  name = "tech504-callum-ansible-db-rules"
  description = "allows ssh and 27017"

  tags = {
    Name = "tech504-callum-tf-allow-ssh-27017"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh-ipv4-again" {
  security_group_id = aws_security_group.tech504-callum-ansible-db-rules.id
  cidr_ipv4         = var.CIDR
  ip_protocol       = "tcp" 
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow-db-traffic" {
  security_group_id = aws_security_group.tech504-callum-ansible-db-rules.id
  cidr_ipv4         = var.CIDR
  ip_protocol       = "tcp" 
  from_port         = 27017
  to_port           = 27017
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh-ipv4-only" {
  security_group_id = aws_security_group.tech504-callum-ansible-ssh-only.id
  cidr_ipv4         = var.CIDR
  ip_protocol       = "tcp" 
  from_port         = 22
  to_port           = 22
}

#   Allow port 22 from localhost
resource "aws_vpc_security_group_ingress_rule" "allow-ssh-ipv4" {
  security_group_id = aws_security_group.tech504-callum-ansible-ssh-http-3000.id
  cidr_ipv4         = var.CIDR
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

#   Allow port 80 from all
resource "aws_vpc_security_group_ingress_rule" "allow-http-ipv4" {
  security_group_id = aws_security_group.tech504-callum-ansible-ssh-http-3000.id
  cidr_ipv4         = var.CIDR
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}

#   Allow port 3000 from all
resource "aws_vpc_security_group_ingress_rule" "allow-tcp-3000" {
  security_group_id = aws_security_group.tech504-callum-ansible-ssh-http-3000.id
  cidr_ipv4         = var.CIDR
  ip_protocol       = "tcp"
  from_port         = 3000
  to_port           = 3000
}

resource "aws_vpc_security_group_egress_rule" "allow-all-egress-1" {
  security_group_id = aws_security_group.tech504-callum-ansible-ssh-http-3000.id
  cidr_ipv4         = var.CIDR
  ip_protocol       = -1
  from_port         = 0
  to_port           = 0
}

resource "aws_vpc_security_group_egress_rule" "allow-all-egress-2" {
  security_group_id = aws_security_group.tech504-callum-ansible-ssh-only.id
  cidr_ipv4         = var.CIDR
  ip_protocol       = -1
  from_port         = 0
  to_port           = 0
}

resource "aws_vpc_security_group_egress_rule" "allow-all-egress-3" {
  security_group_id = aws_security_group.tech504-callum-ansible-db-rules.id
  cidr_ipv4         = var.CIDR
  ip_protocol       = -1
  from_port         = 0
  to_port           = 0
}


#   Modify the EC2 instance created in main.tf:
#   Attach the key to be used with EC2 instance
#   Use security group you created
#   Test infrastructure was created as intended
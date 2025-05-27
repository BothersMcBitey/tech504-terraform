# create an ec2 instance

# where to build this - give cloud provider
# give desired region
provider "aws" {
 region = var.region
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

    key_name = aws_key_pair.tech504-callum-key.id    
    
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

    key_name = aws_key_pair.tech504-callum-key.id    
    
    # instance name
    tags = {
        Name = "tech504-callum-ubuntu-2204-ansible-target-node-app"
    }
}

resource "aws_key_pair" "tech504-callum-key" {
    key_name = "tech504-callum-key"
    public_key = var.public_key
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



#   Modify the EC2 instance created in main.tf:
#   Attach the key to be used with EC2 instance
#   Use security group you created
#   Test infrastructure was created as intended
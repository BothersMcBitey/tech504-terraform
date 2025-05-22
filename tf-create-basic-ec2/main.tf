# create an ec2 instance

# where to build this - give cloud provider
# give desired region
provider "aws" {
 region = var.region
}

# which resource we actually want
resource "aws_instance" "app_instance" {
    # which image do we use? - on AWS called an AMI for some reason.
    # what is AMI ID? ami-0c1c30571d2dae5c9 (ubuntu 22.04lts)
    ami            = var.app_ami_id    

    # which instance type - t3.micro
    instance_type = var.machine
    
    # do we want a public IP?
    associate_public_ip_address = var.is_public

    vpc_security_group_ids = [aws_security_group.tech504-callum-tf-sc.id]

    key_name = aws_key_pair.tech504-callum-key.id    
    
    # instance name
    tags = {
        Name = var.name
    }
}

resource "aws_key_pair" "tech504-callum-key" {
    key_name = "tech504-callum-key"
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINkiPHg6A5qDxtEZU4dMqKdSAC3KQqV7Php3a1ohD4DC callu.re.anderson@gmail.com"
}

# Using Terraform and Terraform official documentation:
# Create an AWS security group named techXXX-firstname-tf-allow-port-22-3000-80 (tf so you know it was created by Terraform)
resource "aws_security_group" "tech504-callum-tf-sc" {

  name = "tech504-callum-tf-sc"
  description = "allows ssh, http, and 3000 traffic"
  #vpc_id = aws_vpc.main.id

  tags = {
    Name = "tech504-callum-tf-allow-port-22-3000-80"
  }
}

#   Allow port 22 from localhost
resource "aws_vpc_security_group_ingress_rule" "allow-ssh-ipv4" {

  security_group_id = aws_security_group.tech504-callum-tf-sc.id

  cidr_ipv4         = "0.0.0.0/0"

  ip_protocol       = "tcp"
  
  from_port         = 22

  to_port           = 22
}

#   Allow port 80 from all
resource "aws_vpc_security_group_ingress_rule" "allow-http-ipv4" {

  security_group_id = aws_security_group.tech504-callum-tf-sc.id

  cidr_ipv4         = "0.0.0.0/0"

  ip_protocol       = "tcp"

  from_port         = 80

  to_port           = 80

}

#   Allow port 3000 from all
resource "aws_vpc_security_group_ingress_rule" "allow-tcp-3000" {

  security_group_id = aws_security_group.tech504-callum-tf-sc.id

  cidr_ipv4         = "0.0.0.0/0"

  ip_protocol       = "tcp"

  from_port         = 3000

  to_port           = 3000

}


#   Modify the EC2 instance created in main.tf:
#   Attach the key to be used with EC2 instance
#   Use security group you created
#   Test infrastructure was created as intended
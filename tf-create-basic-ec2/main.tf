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
    
    # instance name
    tags = {
        Name = var.name
    }
}

# aws access key and secret key - !Never put these in here!



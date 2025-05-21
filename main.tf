# create an ec2 instance

# where to build this - give cloud provider
# give desired region
provider "aws" {
 region = "eu-west-1"
}

# which resource we actually want
resource "aws_instance" "app_instance" {
    # which image do we use? - on AWS called an AMI for some reason.
    # what is AMI ID? ami-0c1c30571d2dae5c9 (ubuntu 22.04lts)
    ami            = "ami-0c1c30571d2dae5c9"

    # which instance type - t3.micro
    instance_type = "t3.micro"
    
    # do we want a public IP?
    associate_public_ip_address = true
    
    # instance name
    tags = {
        Name = "tech504-callum-tf-test-app"
    }
}

# aws access key and secret key - !Never put these in here!



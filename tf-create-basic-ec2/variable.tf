#create var for ami id
#var name is "app_ami_id"

variable "app_ami_id" {
  description = "AMI ID for the EC2 instance we want"
  default   = "ami-0c1c30571d2dae5c9"
}

variable "name" {
    default = "tech504-callum-tf-test-app"
}

variable "region" {
  default = "eu-west-1"
}

variable "machine" {
  default = "t3.micro"
}

variable "is_public" {
  default = true
}

variable "public_key"{
  default =  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINkiPHg6A5qDxtEZU4dMqKdSAC3KQqV7Php3a1ohD4DC callu.re.anderson@gmail.com"
}

variable "CIDR" {
  default = "0.0.0.0/0"
}
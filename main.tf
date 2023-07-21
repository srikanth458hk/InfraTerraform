provider "aws" {
    region = "var.region"
  
}




resource "aws_instance" "web" {
  ami           = "ami-03f65b8614a860c29"
  instance_type = var.instance_type
}

variable "region" {

  
}

variable "instance_type" {
  
}

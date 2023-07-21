provider "aws" {
    region = "ap-south-1"
  
}




resource "aws_instance" "web" {
  ami           = "ami-03f65b8614a860c29"
  instance_type = "t2.micro"
}



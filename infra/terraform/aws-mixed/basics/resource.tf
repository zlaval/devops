provider "aws" {
  access_key = ""
  secret_key = ""
  region = var.AWS_REGION
}

variable "AWS_REGION" {
  type = string
}

variable "AMIS" {
  type = map(string)
  default = {
    eu-central-1= "ami-09042b2f6d07d164a"
  }
}

resource "aws_instance" "example" {
  ami = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
}
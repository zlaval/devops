variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "eu-central-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    eu-central-1= "ami-09042b2f6d07d164a"
  }
}
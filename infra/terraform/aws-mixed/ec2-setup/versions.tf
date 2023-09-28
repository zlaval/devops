terraform {
  required_version = ">=1.2.3"
  backend "s3" {
    bucket         = "zlrx-terraform-state"
    key            = "ec2infra"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "ec2-infra-state-lock"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2"
    }
  }
}
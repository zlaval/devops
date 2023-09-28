terraform {
  required_version = ">=1.2.3"
  backend "s3" {
    bucket         = "zlrx-terraform-state"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "zlrx-terraform-state-lock"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2"
    }
    random = {
      source= "hashicorp/random"
      version="~> 3.3"
    }
  }
}
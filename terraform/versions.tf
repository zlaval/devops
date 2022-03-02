terraform {
  backend "s3" {
    bucket  = "zlrx-playground-tfstate"
    key     = "playground.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2"
    }
    cloudinit = {
      source = "hashicorp/cloudinit"
      version = "~> 2.2"
    }
    random = {
      source= "hashicorp/random"
      version="~> 3.1"
    }
  }
}
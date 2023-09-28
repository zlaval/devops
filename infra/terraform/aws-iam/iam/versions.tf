terraform {
  required_version = ">=1.4.6"
  backend "s3" {
    bucket         = "zlrx-terraform-state"
    key            = "iam.terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "zlrx-terraform-state-lock"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
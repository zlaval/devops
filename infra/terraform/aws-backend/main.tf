provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = {
      Environment = "Terraform Backend"
    }
  }
}

resource "aws_s3_bucket" "zlrx-terraform-state" {
  bucket        = "zlrx-terraform-state"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.zlrx-terraform-state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.zlrx-terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.zlrx-terraform-state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "zlrx-terraform-state-lock" {
  name           = "zlrx-terraform-state-lock"
  read_capacity  = 20
  write_capacity = 10
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
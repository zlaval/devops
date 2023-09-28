variable "region" {
  description = "AWS Region"
  default     = "eu-central-1"
  type        = string
}

variable "namespace" {
  description = "Project namespace"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "ssh_key" {
  description = "Public key for EC2 ssh login"
  type        = string
}
variable "namespace" {
  description = "The project namespace"
  default     = "dev"
  type        = string
}

variable "project_name" {
  default = "example_project"
  type    = string
}

variable "ssh_keypair" {
  description = "SSH keys for EC2"
  default     = null
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "eu-central-1"
  type        = string
}



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
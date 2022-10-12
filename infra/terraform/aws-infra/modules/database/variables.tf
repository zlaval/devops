variable "namespace" {
  type = string
}

variable "project_name" {
  type = string
}

variable "vpc" {
  type = any
}

variable "app_security_group" {
  type = any
}

variable "subnet" {
  type = object({
    private_a = any
    private_b = any
  })
}
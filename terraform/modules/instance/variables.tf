variable "namespace" {
  type = string
}

variable "project_name" {
  type = string
}

variable "ssh_key" {
  type = string
}

variable "alb" {
  type = object({
    lb = any
    sg = any
  })
}

variable "subnet" {
  type = object({
    public_a  = any
    public_b  = any
    private_a = any
    private_b = any
  })
}

variable "vpc" {
  type = any
}

variable "db_config" {
  type = object( {
    user     = string
    password = string
    database = string
    hostname = string
    port     = number
  })
}
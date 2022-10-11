variable "port" {
  type        = number
  description = "database port"
}

variable "subnet_name" {
  type        = string
  description = "Name of the database subnet"
}

variable "name" {
  type        = string
  description = "Name of the database"
}

variable "vpc" {
  type        = any
  description = "VPC of the database subnet"
}

variable "credentials" {
  type = object({
    user      = string
    password  = string
    namespace = string
  })
  description = "DB namespace, user and password"
}

variable "instance_properties" {
  type = object({
    instance_class = string
    engine         = string
    engine_version = string
    licence        = string
    storage        = number
  })
}
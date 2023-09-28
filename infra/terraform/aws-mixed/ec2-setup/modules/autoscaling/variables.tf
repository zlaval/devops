variable "namespace" {
  type = string
}

variable "project_name" {
  type = string
}

variable "security_group" {
  type = object({
    load_balancer = any
    application   = any
    database      = any
  })
}

variable "subnet" {
  type = object({
    public  = any
    private = any
  })
}

variable "vpc" {
  type = any
}
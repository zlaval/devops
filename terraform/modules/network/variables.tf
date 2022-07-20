variable "namespace" {
  type = string
}

variable "project_name" {
  type = string
}

variable "blocked_ips" {
  type    = list(string)
  default = [
    "50.17.188.21/32",
    "37.134.18.17/32"
  ]
}

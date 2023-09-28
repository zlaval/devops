variable myvar {
  type = string
  default = "hello world"
}

variable mymap {
  type = map(string)
  default = {
    mykey="my value"
  }
}
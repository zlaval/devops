output "vpc" {
  value = {
    vpc = aws_default_vpc.default
  }
}

output "subnet" {
  value = {
    public  = aws_subnet.public
    private = aws_subnet.private
  }
}

output "security_group" {
  value = {
    load_balancer = aws_security_group.loadbalancer
    application   = aws_security_group.application
    database      = aws_security_group.database
  }
}
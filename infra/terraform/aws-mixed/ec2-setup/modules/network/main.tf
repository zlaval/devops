resource "aws_default_vpc" "default" {}

resource "aws_subnet" "public" {
  vpc_id                  = aws_default_vpc.default.id
  cidr_block              = "172.31.48.0/24"
  map_public_ip_on_launch = true
  tags                    = {
    Name = "public-1"
  }
}

resource "aws_route_table_association" "public_to_default" {
  route_table_id = aws_default_vpc.default.default_route_table_id
  subnet_id      = aws_subnet.public.id
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_default_vpc.default.id
  cidr_block              = "172.31.49.0/24"
  map_public_ip_on_launch = false
  tags                    = {
    Name = "private-1"
  }
}

resource "aws_security_group" "database" {
  name        = "database"
  description = "Allow traffic to database"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    protocol    = "tcp"
    from_port   = 5432
    to_port     = 5432
    cidr_blocks = [aws_security_group.application.id]
    self        = false
  }
}

resource "aws_security_group" "application" {
  name        = "application"
  description = "Allow traffic to application"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = [aws_security_group.loadbalancer.id]
    self        = false
  }
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    self        = false
  }
}

resource "aws_security_group" "loadbalancer" {
  name        = "loadbalancer"
  description = "Allow traffic to loadbalancer"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    self        = false
  }
}

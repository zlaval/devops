resource "aws_default_vpc" "default" {}

resource "aws_route_table" "private" {
  vpc_id = aws_default_vpc.default.id
}

data "aws_region" "current" {
}

resource "aws_subnet" "private_a" {
  vpc_id                  = aws_default_vpc.default.id
  availability_zone       = "${data.aws_region.current.name}a"
  cidr_block              = local.subnet_ips.private_a
  map_public_ip_on_launch = false
  tags                    = {
    Name = "private_a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_default_vpc.default.id
  availability_zone       = "${data.aws_region.current.name}b"
  cidr_block              = local.subnet_ips.private_b
  map_public_ip_on_launch = false
  tags                    = {
    Name = "private_b"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id                  = aws_default_vpc.default.id
  availability_zone       = "${data.aws_region.current.name}c"
  cidr_block              = local.subnet_ips.private_c
  map_public_ip_on_launch = false
  tags                    = {
    Name = "private_c"
  }
}

resource "aws_route_table_association" "private_a_to_private" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_a.id
}

resource "aws_route_table_association" "private_b_to_private" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_b.id
}

resource "aws_route_table_association" "private_c_to_private" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_c.id
}

locals {
  subnet_ips = {
    private_a = "172.31.48.0/24"
    private_b = "172.31.49.0/24"
    private_c = "172.31.50.0/24"
  }
  private_subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id,
    aws_subnet.private_c.id
  ]
}

resource "aws_db_subnet_group" "rds-subnet-group" {
  subnet_ids = local.private_subnet_ids
}

module "datasource-postgres" {
  source      = "./module/datasource"
  name        = "postgres"
  vpc         = aws_default_vpc.default
  port        = 5432
  subnet_name = aws_db_subnet_group.rds-subnet-group.name
  credentials = {
    user      = "zlaval"
    password  = "K8tyI8v*c"
    namespace = "test"
  }
  instance_properties = {
    instance_class = "db.t3.micro"
    engine         = "postgres"
    engine_version = "14.4"
    licence        = null
    storage        = 5
  }
}

module "datasource-mssql" {
  source      = "./module/datasource"
  name        = "mssql"
  vpc         = aws_default_vpc.default
  port        = 1433
  subnet_name = aws_db_subnet_group.rds-subnet-group.name
  credentials = {
    user      = "zlaval"
    password  = "K8tyI8v*c"
    namespace = null
  }
  instance_properties = {
    instance_class = "db.t3.xlarge"
    engine         = "sqlserver-se"
    engine_version = "15.00.4043.16.v1"
    licence        = "license-included"
    storage        = 20
  }
}



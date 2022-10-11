resource "aws_security_group" "rds-security-group" {
  name        = "${var.name}-security-group"
  description = "Allow traffic to database"
  vpc_id      = var.vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = var.port
    to_port     = var.port
    cidr_blocks = [var.vpc.cidr_block]
    self        = false
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_db_instance" "database" {
  instance_class              = var.instance_properties.instance_class
  allocated_storage           = 20
  allow_major_version_upgrade = true
  engine                      = var.instance_properties.engine
  engine_version              = var.instance_properties.engine_version
  db_name                     = var.credentials.namespace
  username                    = var.credentials.user
  password                    = var.credentials.password
  skip_final_snapshot         = true
  multi_az                    = false
  backup_retention_period     = 0
  identifier                  = "${var.name}-db"
  db_subnet_group_name        = var.subnet_name
  vpc_security_group_ids      = [aws_security_group.rds-security-group.id]
  license_model               = var.instance_properties.licence
}
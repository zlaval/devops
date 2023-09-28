resource "aws_db_subnet_group" "db_subnet" {
  name       = "db_subnet"
  subnet_ids = [var.subnet.private]
}

resource "aws_db_instance" "database" {
  instance_class              = "db.t2.micro"
  allocated_storage           = 1
  allow_major_version_upgrade = true
  engine                      = "postgresql"
  engine_version              = "14"
  db_name                     = "car_db"
  username                    = "zlaval"
  password                    = "Tb5E87jI"
  skip_final_snapshot         = true
  multi_az                    = false
  backup_retention_period     = 0
  identifier                  = "${var.namespace}-${var.project_name}-db"
  db_subnet_group_name        = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids      = [var.security_group.database]
}
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@#"
}

resource "aws_db_instance" "database" {
  instance_class         = "db.t2.micro"
  allocated_storage      = 1
  engine                 = "postgresql"
  engine_version         = "14"
  identifier             = "${var.namespace}-${var.project_name}-db"
  db_name                = "demo_db"
  username               = "zlaval"
  password               = random_password.password.result
  db_subnet_group_name   = var.vpc.database_subnet_group
  vpc_security_group_ids = [var.sg.db]
  skip_final_snapshot    = true
}
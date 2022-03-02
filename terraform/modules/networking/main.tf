data "aws_availability_zones" "available" {}

module "vpc" {
  source                       = "terraform-aws-modules/vpc/aws"
  version                      = "3.12.0"
  name                         = "${var.namespace}-${var.project_name}-vpc"
  cidr                         = "10.0.0.0/16"
  azs                          = data.aws_availability_zones.available.names
  private_subnets              = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets               = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnets             = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
  create_database_subnet_group = true
  enable_nat_gateway           = true
  single_nat_gateway           = true
}

module "lb_sg" {
  source        = "terraform-in-action/sg/aws"
  vpc_id        = module.vpc.vpc_id
  ingress_rules = [
    {
      port        = 80
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "websvr_sg" {
  source        = "terraform-in-action/sg/aws"
  vpc_id        = module.vpc.vpc_id
  ingress_rules = [
    {
      port        = 8080
      cidr_blocks = [module.lb_sg.security_group.id]
    },
    {
      port        = 22
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "db_sg" {
  source        = "terraform-in-action/sg/aws"
  vpc_id        = module.vpc.vpc_id
  ingress_rules = [
    {
      port        = 3306
      cidr_blocks = [module.websvr_sg.security_group.id]
    }
  ]
}
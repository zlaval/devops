module "network" {
  source = "./modules/network"

  namespace    = var.namespace
  project_name = var.project_name
}

module "database" {
  source = "./modules/database"

  namespace    = var.namespace
  project_name = var.project_name

  security_group = module.network.security_group
  subnet         = module.network.subnet
}

module "autoscaling" {
  source = "./modules/autoscaling"

  namespace    = var.namespace
  project_name = var.project_name

  security_group = module.network.security_group
  subnet         = module.network.subnet
  vpc            = module.network.vpc
}
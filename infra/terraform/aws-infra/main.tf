module "network" {
  source       = "./modules/network"
  namespace    = var.namespace
  project_name = var.project_name
}

module "instance" {
  source       = "./modules/instance"
  namespace    = var.namespace
  project_name = var.project_name
  ssh_key      = var.ssh_key
  alb          = module.network.alb
  subnet       = module.network.subnet
  vpc          = module.network.vpc
  db_config    = module.database.db_config
}

module "database" {
  source             = "./modules/database"
  namespace          = var.namespace
  project_name       = var.project_name
  vpc                = module.network.vpc
  app_security_group = module.instance.security_group
  subnet             = module.network.subnet
}
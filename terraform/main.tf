module "autoscaling" {
  source       = "./modules/autoscaling"
  namespace    = var.namespace
  project_name = var.project_name
  ssh_keypair  = var.ssh_keypair

  vpc          = module.networking.vpc
  sg           = module.networking.sg
  db_config    = module.database.db_config
}

module "database" {
  source       = "./modules/database"
  namespace    = var.namespace
  project_name = var.project_name
  vpc          = module.networking.vpc
  sg           = module.networking.sg
}

module "networking" {
  source       = "./modules/networking"
  namespace    = var.namespace
  project_name = var.project_name
}
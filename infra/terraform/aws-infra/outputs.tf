output "public_subnet" {
  value = module.network.subnet
}

output "database" {
  value     = module.database.db_config
  sensitive = true
}

output "alb" {
  value = module.network.alb.lb.dns_name
}
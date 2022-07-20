output "public_subnet" {
  value = module.network.subnet
}

output "database" {
  value     = module.database.db_config
  sensitive = true
}
output "test_vm_ip" {
  value       = module.compute.public_ip_address
  # sensitive   = true
}

output "test_vm_name" {
  value       = module.compute.vm_name
}

output "test_mysql_fqdn" {
  value       = module.database.test_mysql_fqdn
  # sensitive   = true
}

output "test_mysql_admin" {
  value       = module.database.test_mysql_admin
  # sensitive   = true
}

output "test_mysql_password" {
  value       = module.database.test_mysql_password
  # sensitive   = true
}

output "test_mysql_db_name" {
  value       = module.database.test_mysql_db_name
}



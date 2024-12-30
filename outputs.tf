output "ssh_observer_mini" {
  value = "ssh -i ${module.key_pair.private_key_file} ec2-user@${module.ec2.observer_mini_public_dns}"
}

output "elastc_password" {
  value     = module.ec2.elastic_password
  sensitive = true
}

output "kibana_login" {
  value = "http://${module.ec2.observer_mini_public_dns}:${var.elastic_config.kibana_port}"
}

output "elasticsearch_url" {
  value = "https://${module.ec2.observer_mini_public_dns}:${var.elastic_config.es_port}"
}

output "apm_url" {
  value = "http://${module.ec2.observer_mini_public_dns}:${var.elastic_config.apm_port}"
}


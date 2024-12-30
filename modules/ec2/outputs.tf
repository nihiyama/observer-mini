output "observer_mini_public_dns" {
  value = aws_instance.observer_mini.public_dns
}

output "elastic_password" {
  value = random_password.elastic_password.result
}

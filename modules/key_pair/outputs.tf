output "key_name" {
  value = aws_key_pair.key_pair.key_name
}

output "private_key" {
  value = tls_private_key.keygen.private_key_pem
}

output "public_key_file" {
  value = local.public_key_file
}

output "private_key_file" {
  value = local.private_key_file
}

output "public_key_openssh" {
  value = tls_private_key.keygen.public_key_openssh
}

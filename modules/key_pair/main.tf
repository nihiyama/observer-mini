resource "tls_private_key" "keygen" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

locals {
  public_key_file  = "~/.ssh/${var.basename}-${terraform.workspace}.id_rsa.pub"
  private_key_file = "~/.ssh/${var.basename}-${terraform.workspace}.id_rsa"
}

resource "local_file" "private_key" {
  filename = pathexpand(local.private_key_file)
  content  = tls_private_key.keygen.private_key_pem

  provisioner "local-exec" {
    command = "chmod 600 ${local.private_key_file}"
  }
}

resource "local_file" "public_key" {
  filename = pathexpand(local.public_key_file)
  content  = tls_private_key.keygen.public_key_openssh

  provisioner "local-exec" {
    command = "chmod 600 ${local.public_key_file}"
  }
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.basename}-${terraform.workspace}"
  public_key = tls_private_key.keygen.public_key_openssh
}

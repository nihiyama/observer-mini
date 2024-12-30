resource "aws_instance" "observer_mini" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  user_data              = data.template_file.user_data.rendered

  root_block_device {
    volume_type = "gp3"
    volume_size = var.volume_size
  }

  lifecycle {
    ignore_changes = [
      ami,
    ]
  }

  tags = {
    Name = "${var.basename}"
  }
}

resource "random_password" "elastic_password" {
  length  = 24
  special = false
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp3"]
  }
}

data "template_file" "compose" {
  template = file("${path.module}/template_files/compose.yaml.tpl")
  vars = {
    elastic_version  = var.elastic_config.elastic_version
    elastic_password = random_password.elastic_password.result
    cluster_name     = var.elastic_config.cluster_name
    license          = var.elastic_config.license
    es_port          = var.elastic_config.es_port
    kibana_port      = var.elastic_config.kibana_port
    apm_port         = var.elastic_config.apm_port
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/template_files/user_data.yml.tpl")

  vars = {
    compose                = base64encode(data.template_file.compose.rendered)
    apm                    = filebase64("${path.module}/template_files/apm-server.docker.yml.tpl")
    docker_compose_version = var.docker_compose_version
  }
}

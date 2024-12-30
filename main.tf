provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = var.aws_default_region
}

module "network" {
  source         = "./modules/network/"
  basename       = var.basename
  vpc_cidr_block = var.vpc_cidr_block
}

module "firewall" {
  source                         = "./modules/firewall/"
  basename                       = var.basename
  vpc_id                         = module.network.vpc_id
  ingress_management_ports       = var.ingress_management_ports
  ingress_management_cidr_blocks = var.ingress_management_cidr_blocks
  ingress_service_ports          = var.ingress_service_ports
  ingress_service_cidr_blocks    = var.ingress_service_cidr_blocks
}

module "key_pair" {
  source   = "./modules/key_pair/"
  basename = var.basename
}

module "ec2" {
  source                 = "./modules/ec2/"
  basename               = var.basename
  key_name               = module.key_pair.key_name
  instance_type          = var.instance_type
  volume_size            = var.volume_size
  docker_compose_version = var.docker_compose_version
  subnet_id              = module.network.subnet_id
  security_group_ids     = [module.firewall.sg_id]

  # config
  elastic_config = var.elastic_config
}

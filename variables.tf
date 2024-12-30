###################################################################
# Please set access_key_id, secret_access_key and default region  #
# as environment variables prefixed with "TF_VARS_".              #
# For example, TF_VAR_aws_access_key_id = AKIA********.           #
###################################################################

### environment variables
variable "aws_access_key_id" {
  type        = string
  description = "AWS access key id"
}
variable "aws_secret_access_key" {
  type        = string
  description = "AWS secret access key"
}
variable "aws_default_region" {
  type        = string
  description = "AWS default region"
  default     = "ap-northeast-1"
}

### common
variable "basename" {
  type        = string
  description = "this project basename."
  default     = "observer-mini"
}

### network
variable "vpc_cidr_block" {
  type        = string
  description = "vpc cidr block"
  default     = "10.0.0.0/16"
}

### firewall
variable "ingress_management_ports" {
  type = object({
    ssh = number
  })
  description = "ingress management ports"
  default = {
    ssh = 22
  }
}
variable "ingress_management_cidr_blocks" {
  type        = list(string)
  description = "ingress managemnt cidr blocks"
  default     = []
}
variable "ingress_service_ports" {
  type = object({
    elasticsearch = number
    kibana        = number
    apm           = number
  })
  description = "ingress service ports"
  default = {
    elasticsearch = 9200
    kibana        = 5601
    apm           = 8200
  }
}
variable "ingress_service_cidr_blocks" {
  type        = list(string)
  description = "ingress service cidr blocks"
  default     = []
}

### ec2 instance
variable "instance_type" {
  type        = string
  description = "observer-mini instance type"
  default     = "t3.xlarge"
}
variable "volume_size" {
  type        = string
  description = "observer-mini volume size"
  default     = 30
}
variable "docker_compose_version" {
  type        = string
  description = "docker compose version"
  default     = "v2.31.0"
}

### config
variable "elastic_config" {
  type = object({
    elastic_version = string
    cluster_name    = string
    license         = string
    es_port         = number
    kibana_port     = number
    apm_port        = number
  })
  description = "elastic configurations"
  default = {
    elastic_version = "8.16.1"
    cluster_name    = "observer-mini"
    license         = "basic"
    es_port         = 9200
    kibana_port     = 5601
    apm_port        = 8200
  }
}

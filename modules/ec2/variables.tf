### common
variable "basename" {}


### ec2 key pair
variable "key_name" {
  type        = string
  description = "key name for ssh."
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

### docker-compose version
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

### network
variable "security_group_ids" {
  type        = list(string)
  description = "security group ids for observer"
}

variable "subnet_id" {
  type        = string
  description = "subnet id"
}



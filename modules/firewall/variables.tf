### common
variable "basename" {}

### firewall
variable "vpc_id" {
  type        = string
  description = "vpc id from vpc resource in Networking module"
}

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
  description = "Open these cidr blocks of servers for management from somewhere."
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


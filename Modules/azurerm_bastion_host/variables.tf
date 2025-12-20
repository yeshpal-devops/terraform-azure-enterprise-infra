variable "dev_bastion" {
  type = map(any)
}

variable "dev_rg" {
  type = map(any)
}

variable "dev_subnet_ids" {
  type = map(any)
  default = {}
}

variable "dev_public_ip_ids" {
  type = map(any)
  default = {}
}

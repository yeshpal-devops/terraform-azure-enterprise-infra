variable "dev_nic" {
  type = map(any)
}

variable "dev_rg" {
  type = map(any)
}

variable "dev_subnet_ids" {
  type = map(any)
  default = {}
}

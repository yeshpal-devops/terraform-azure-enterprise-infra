variable "dev_sql_server" {
  type = map(any)
}

variable "dev_rg" {
  type = map(any)
}

variable "key_vault_id" {
  type = string
  default = ""
}

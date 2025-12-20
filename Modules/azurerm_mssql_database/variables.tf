variable "dev_sql_database" {
  type = map(any)
}

variable "dev_sql_server_ids" {
  type = map(any)
  default = {}
}

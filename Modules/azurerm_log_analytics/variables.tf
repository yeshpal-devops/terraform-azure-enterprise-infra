variable "log_analytics" {
  description = "Log Analytics workspace configuration."
  type        = map(any)
}

variable "dev_rg" {
  description = "Resource group configuration used by the environment."
  type        = map(any)
}

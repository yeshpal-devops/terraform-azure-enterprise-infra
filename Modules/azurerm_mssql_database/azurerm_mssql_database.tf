resource "azurerm_mssql_database" "sql" {
  for_each = var.dev_sql_database
  name         = each.value.name
  server_id    = var.dev_sql_server_ids[each.key]
  collation    = lookup(each.value, "collation", "SQL_Latin1_General_CP1_CI_AS")
  license_type = lookup(each.value, "license_type", null)
  max_size_gb  = lookup(each.value, "max_size_gb", null)
  sku_name     = lookup(each.value, "sku_name", "Basic")
  enclave_type = lookup(each.value, "enclave_type", null)

  tags = lookup(each.value, "tags", {})

  # prevent the possibility of accidental data loss
 
  lifecycle {
    prevent_destroy = true
  }
}
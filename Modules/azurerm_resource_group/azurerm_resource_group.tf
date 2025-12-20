resource "azurerm_resource_group" "rg" {
    for_each = var.dev_rg
  name     = each.value.name
  location = each.value.location

  tags = {
    environment = each.value.environment
  }
}
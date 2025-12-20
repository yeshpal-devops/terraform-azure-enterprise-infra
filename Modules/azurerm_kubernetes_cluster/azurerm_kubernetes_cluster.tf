resource "azurerm_kubernetes_cluster" "aks" {
  for_each = var.dev_aks
  name                = each.value.name
  location            = var.dev_rg[each.value.rg_key].location
  resource_group_name = var.dev_rg[each.value.rg_key].name
  dns_prefix          = each.value.dns_prefix
  default_node_pool {
    name       = lookup(each.value, "node_pool_name", "default")
    node_count = lookup(each.value, "node_count", 1)
    vm_size    = lookup(each.value, "vm_size", "Standard_D2_v2")
  }

  identity {
    type = lookup(each.value, "identity_type", "SystemAssigned")
  }

  tags = {
    Environment = var.dev_rg[each.value.rg_key].environment
  }
}

output "client_certificate" {
  value = {
    for k, v in azurerm_kubernetes_cluster.aks :
    k => v.kube_config[0].client_certificate
  }
  sensitive = true
}

output "kube_config" {
  value = {
    for k, v in azurerm_kubernetes_cluster.aks :
    k => v.kube_config_raw
  }
  sensitive = true
}

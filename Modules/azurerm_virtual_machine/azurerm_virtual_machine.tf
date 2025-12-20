resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.dev_vm
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  disable_password_authentication = false
  admin_username      = lookup(each.value, "admin_user", "azureuser")
  admin_password      = data.azurerm_key_vault_secret.secret[each.key].value
  network_interface_ids = [
    data.azurerm_network_interface.nic[each.key].id
  ]

  os_disk {
    caching              = lookup(each.value, "os_disk_caching", "ReadWrite")
    storage_account_type = lookup(each.value, "os_disk_storage_account_type", "Standard_LRS")
  }

  source_image_reference {
    publisher = lookup(each.value, "source_image_publisher", "Canonical")
    offer     = lookup(each.value, "source_image_offer", "UbuntuServer")
    sku       = lookup(each.value, "source_image_sku", "18.04-LTS")
    version   = lookup(each.value, "source_image_version", "latest")
  }
}
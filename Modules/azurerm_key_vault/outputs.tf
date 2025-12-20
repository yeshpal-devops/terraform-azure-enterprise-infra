output "key_vault_id" {
  value = {
    for k, v in azurerm_key_vault.vault :
    k => v.id
  }
}

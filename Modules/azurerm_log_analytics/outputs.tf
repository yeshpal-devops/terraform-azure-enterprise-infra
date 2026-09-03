output "workspace_id" {
  description = "Resource IDs of the Log Analytics workspaces."
  value = {
    for k, v in azurerm_log_analytics_workspace.workspace : k => v.id
  }
}

output "workspace_resource_ids" {
  description = "Resource IDs for use by monitoring integrations."
  value = {
    for k, v in azurerm_log_analytics_workspace.workspace : k => v.resource_id
  }
}

output "tfstate_primary_access_key" {
  sensitive = true
  value     = azurerm_storage_account.state.primary_access_key
}


output "webapp_url" {
  value = "http://${azurerm_app_service.webapp.name}.azurewebsites.net"
}

output "webapp_slot_urls" {
  value = ["${formatlist("http://${azurerm_app_service.webapp.name}-%v.azurewebsites.net", azurerm_app_service_slot.slots.*.name)}"]
}

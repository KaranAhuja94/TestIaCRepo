resource "azurerm_search_service" "cid50391search-pass" {
  name = "cid50391search-pass"
  resource_group_name = "Resource-Group-Karan"
  location = "East US"
  sku = "free"
  identity {
    type = "SystemAssigned"
  }
}
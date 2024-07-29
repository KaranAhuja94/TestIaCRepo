resource "azurerm_storage_account" "cid50393storageaccount-fail" {
  name = "storageacccountfail"
  resource_group_name = "Resource-Group-Karan"
  location = "East US"
  account_replication_type = "LRS"
  account_tier = "Standard"
}

resource "azurerm_storage_account_network_rules" "cid50393networkrulefail" {
  storage_account_id = azurerm_storage_account.cid50393storageaccount-fail.id
  default_action = "Deny"
}
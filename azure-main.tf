terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "1d767489-da0c-4948-a285-bf2c708c0586"
  features {
  }
}

resource "azurerm_resource_group" "test-resource-group" {
  name = "test-resource-group"
  location = "East US"
}

resource "azurerm_managed_disk" "test-managed-disk" {
  name = "test-managed-disk"
  location = azurerm_resource_group.test-resource-group.location
  resource_group_name = azurerm_resource_group.test-resource-group.name
  storage_account_type = "Standard_LRS"
  create_option = "Empty"
  # control id 50156 - Pass
  public_network_access_enabled = "true"
  network_access_policy = "DenyAll"
}

resource "azurerm_security_center_subscription_pricing" "security-center-princing" {
  # control id 50015 - Fail
  tier = "Free"
  resource_type = "VirtualMachines"
}
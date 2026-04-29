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
  name     = "test-resource-group"
  location = "East US"
  tags = {
    yor_trace = "49691183-4fb9-4654-8e13-f27a05442371"
  }
}

resource "azurerm_managed_disk" "test-managed-disk" {
  name                 = "test-managed-disk"
  location             = azurerm_resource_group.test-resource-group.location
  resource_group_name  = azurerm_resource_group.test-resource-group.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  # control id 50156 - Pass
  public_network_access_enabled = "true"
  network_access_policy         = "DenyAll"
  tags = {
    yor_trace = "7713d3f5-b213-4a53-ab7e-bdf05f0a2fee"
  }
}

resource "azurerm_security_center_subscription_pricing" "security-center-princing" {
  # control id 50015 - Fail
  tier          = "Free"
  resource_type = "VirtualMachines"
}
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

data "azurerm_client_config" "current" {}

resource "azurerm_storage_account" "storage-account-test" {
  name                     = "storageaccountiac29"
  resource_group_name      = "hktest20"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  # 50011
  https_traffic_only_enabled = true
  tags = {
    createdBy = "Karan"
    purpose   = "IaC testing"
  }
}

resource "azurerm_virtual_network" "virtualnetwork" {
  name                = "vnetiactest"
  address_space       = ["10.0.0.0/16"]
  location            = "West Europe"
  resource_group_name = "hktest20"
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnetiactest"
  resource_group_name  = "hktest20"
  virtual_network_name = azurerm_virtual_network.virtualnetwork.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_private_endpoint" "stroage-account-private-endpoint" {
  name                = "storageaccountprivateendpoint"
  resource_group_name = "hktest20"
  location            = "West Europe"
  subnet_id           = azurerm_subnet.subnet.id
  private_service_connection {
    name                 = "privateEndpointIaCTest"
    is_manual_connection = false
    # 50313
    private_connection_resource_id = azurerm_storage_account.storage-account-test.id
    subresource_names = [ "blob" ]
  }
}

resource "azurerm_key_vault" "key-vault" {
  name                       = "keyVaultIaCTest"
  location                   = "West Europe"
  resource_group_name        = "hktest20"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  sku_name                   = "standard"
}

resource "azurerm_monitor_diagnostic_setting" "monitor-diagnostic-setting" {
  name               = "monitorDiagnosticSettingIaCTest"
  target_resource_id = azurerm_key_vault.key-vault.id
  storage_account_id = azurerm_storage_account.storage-account-test.id
  # 50142
  #log {
  #  category = "Administrative"
  #}
  # 50075
  enabled_log {
    category = "AuditEvent"
  }
}

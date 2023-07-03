terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.10.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
#  subscription_id = "cb23ce95-c06b-438d-9ecc-dfa9f5765d07"
#  tenant_id = "98053b55-fa1e-4ce4-a468-32d616d84884"
#  client_id = "9d6a6e6b-dcf4-4690-945b-2db871126e65" 
#  client_secret = "gNL8Q~~DCU_86E3qdd6n6Y8xCamv9Pn6UZWD5cEi"
  features {}
}
  

resource "azurerm_resource_group" "myrg" {
  name     = "myrg1"
  location = "West Europe"
}

resource "azurerm_storage_account" "mystorageaccount999832" {
  name                     = "mystorageaccount999832"
  resource_group_name      = azurerm_resource_group.myrg.name
  location                 = azurerm_resource_group.myrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.mystorageaccount999832.name
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "blob" {
  name                   = "main.tf"
  storage_account_name   = azurerm_storage_account.mystorageaccount999832.name
  storage_container_name = azurerm_storage_container.data.name
  type                   = "Block"
  source                 = "main.tf"
}
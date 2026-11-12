# terraform/blob_demo.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "demo" {
  name     = "rg-iac-demo"
  location = "canadacentral"
}

resource "azurerm_storage_account" "demo" {
  name                            = "stiacdemo001"
  resource_group_name             = azurerm_resource_group.demo.name
  location                        = azurerm_resource_group.demo.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
}

resource "azurerm_storage_container" "demo" {
  name                  = "data"
  storage_account_id    = azurerm_storage_account.demo.id
  container_access_type = "private"
}


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
  subscription_id = var.subscription_id
}

variable "subscription_id" {
  type = string
}

resource "azurerm_resource_group" "demo" {
  name     = "rg-demo-blob"
  location = "canadacentral"
}

resource "azurerm_storage_account" "demo" {
  name                     = "demoblob12345678"
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Basic security
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = true
}

resource "azurerm_storage_container" "demo" {
  name                  = "demo-blob"
  storage_account_id    = azurerm_storage_account.demo.id
  container_access_type = "private"
}


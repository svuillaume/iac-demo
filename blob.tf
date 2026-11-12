
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
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

resource "random_string" "suffix" {
  length  = 8
  upper   = false
  special = false
}

resource "azurerm_resource_group" "demo" {
  name     = "rg-demo-blob"
  location = "canadacentral"
}

resource "azurerm_storage_account" "demo" {
  name                     = "demoblob${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Security controls
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false
  public_network_access_enabled   = false
}

resource "azurerm_storage_container" "demo" {
  name                  = "demo-blob"
  storage_account_id    = azurerm_storage_account.demo.id
  container_access_type = "private"
}

output "storage_account_name" {
  value = azurerm_storage_account.demo.name
}


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
  name     = "rg-cnapp-insecure-demo"
  location = "canadacentral"
}

resource "azurerm_storage_account" "demo" {
  name                     = "cnappdemo${substr(md5(azurerm_resource_group.demo.id), 0, 10)}"
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # INTENTIONALLY INSECURE
  allow_nested_items_to_be_public = true
  https_traffic_only_enabled      = false
  public_network_access_enabled   = true

  min_tls_version = "TLS1_2"
}

resource "azurerm_storage_container" "demo" {
  name                  = "public-demo"
  storage_account_id    = azurerm_storage_account.demo.id
  container_access_type = "blob"
}

output "blob_container_url" {
  value = "${azurerm_storage_account.demo.primary_blob_endpoint}${azurerm_storage_container.demo.name}"
}


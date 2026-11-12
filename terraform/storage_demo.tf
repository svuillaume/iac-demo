resource "random_id" "s" {
  byte_length = 4
}

resource "azurerm_resource_group" "demo" {
  name     = "rg-iac-demo"
  location = "canadacentral"
}

resource "azurerm_storage_account" "demo" {
  name                            = "stiacdemo${random_id.s.hex}"
  resource_group_name             = azurerm_resource_group.demo.name
  location                        = azurerm_resource_group.demo.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
}

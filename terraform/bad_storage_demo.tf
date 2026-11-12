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
  allow_nested_items_to_be_public = true     # CHANGED: was false, allows anonymous blob access
  public_network_access_enabled   = true     # ADDED: reachable from the internet
  min_tls_version                 = "TLS1_2"

  network_rules {                            # ADDED: no IP restriction
    default_action = "Allow"
  }
}

# ADDED: container readable anonymously
resource "azurerm_storage_container" "public" {
  name                  = "public-data"
  storage_account_id    = azurerm_storage_account.demo.id
  container_access_type = "blob"
}

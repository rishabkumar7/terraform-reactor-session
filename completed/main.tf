provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name     = "terraform-reactor"
  location = "eastus"
}

resource "azurerm_storage_account" "storage_account" {
  name                = "storagefortfdemo0076"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location

  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "StorageV2"
  enable_https_traffic_only = true
  allow_blob_public_access  = true

  static_website {
    index_document = "index.html"
  }
}

resource "azurerm_storage_blob" "example" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source_content         = "<h1>Hola!</h1>"
}

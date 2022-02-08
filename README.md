# Terraform Reactor Session

Simple static site deployed to azure storage with Terraform.

## What is Terraform?

HashiCorp Terraform is an infrastructure as code tool that lets you define both cloud and on-prem resources in human-readable configuration files that you can version, reuse, and share.

## Azure Provider in Terraform

The Azure Provider can be used to configure infrastructure in Microsoft Azure using the Azure Resource Manager API's. Read more about the provider [here.](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)

## Deploying a Static Website

Here is the main terraform file in which we define the provider first and then the resource group called `terraform-reactor`. We are creating a storage account with the static website and finally, we are adding the index.html content to the blob storage.

``` hcl
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
```

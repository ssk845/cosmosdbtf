terraform {
  required_version = ">= 0.12.6"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-stg-tf"
    storage_account_name = "tfstoresk"
    container_name       = "tfstores"
    key                  = "terraform.tfstate"
  }
}  
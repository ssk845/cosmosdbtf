# Name of the provisioned cosmosdb database 
variable "cosmosdb_account_name" {
    description = "Name of the CosmosDB Account"
    type        = string
}

# Name of the resource group to deploy to 
variable "resource_group_name" {
    description = "Name of the resource group to deploy resources in"
    type        = string
}

#Region to deploy resource to 
variable "location" {
    description = "The Azure Region in which to create resource"
    type        = string
}

# Target Subscription ID
variable "subscription_id" {
    description =  "Azure subscrition ID"
    type        =  string
}

# Target Tenant ID 
variable "tenant_id" {
    type = string
}

# Object Map of tags to apply the service 
variable "tags" {
    type = map(any)
    default = {}
}

variable "cosmosdb_kind" {
    type    = string
 
}

variable "cosmosdb_capabilities" {
    type    = list(string)
}

variable "cosmosdb_env_lineup" {
    type    = string
}

variable "private_endpoint_name" {
    type        = string
    description = "Name of the private endpoint"
}

variable "private_endpoint_rg" {
    type        = string
    description = "resource group name for the PE to be deployed"
}

variable "private_endpoint_subnet" {
    type        = string 
    description = "full subnet id of where PE should be deployed"
}

variable "private_endpoint_subresource_name" {
  type          = string
  description   = "a sub resource name for the private end point connection"
  default       = "Sql"
}

variable "private_endpoint_service_name" {
    type        = string
    description = "name of the private end point service"
  
}

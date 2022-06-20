resource "azurerm_cosmosdb_account" "cosmosdb" {
    name                = var.cosmosdb_account_name
    location            = var.location
    resource_group_name = var.resource_group_name
    offer_type          = "Standard"
    kind                = var.cosmosdb_kind

    enable_automatic_failover = false
    ip_range_filter           = "199.60.112.94,199.60.112.92"
    
    dynamic "capabilities" {
        for_each = var.cosmosdb_capabilities
        content {
            name = capabilities.value
        }
        
    }

    capabilities{
        name = "DisableRateLimitingResponses"
    }

    enable_free_tier = false

    enable_multiple_write_locations = false

    is_virtual_network_filter_enabled = true
    public_network_access_enabled = false 

    mongo_server_version = var.cosmosdb_kind == "MongoDB" ? "4.0" : null

    consistency_policy {
        consistency_level       = "Session"
        max_interval_in_seconds = 5
        max_staleness_prefix    = 100
    }

    geo_location{
        location          = var.location
        failover_priority = 0
    }

    backup {
        interval_in_minutes = var.cosmosdb_env_lineup == "prod" ? 60 : 240
        retention_in_hours  = var.cosmosdb_env_lineup == "prod" ? 720 : 168
        type                = "Periodic"
    }

    tags = var.tags

    lifecycle {
        prevent_destroy = true

        ignore_changes = [
            name, 
            location,
            resource_group_name,
            offer_type,
            kind,
            enable_automatic_failover,
            ip_range_filter,
            capabilities,
            enable_free_tier,
            enable_multiple_write_locations,
            is_virtual_network_filter_enabled,
            public_network_access_enabled,
            mongo_server_version,
            consistency_policy,
            geo_location,
            backup,
            tags,
            ip_range_filter
        ]
    }
}

resource "azurerm_private_endpoint" "cosmosdb" {
    name = var.private_endpoint_name

    location            = var.location
    resource_group_name = var.private_endpoint_rg
    subnet_id           = var.private_endpoint_subnet

    private_service_connection {
        name                                = var.private_endpoint_name
        private_connection_resource_id      = azurerm_cosmosdb_account.cosmosdb.id
        is_manual_connection                = false
        subresource_names                   = var.private_endpoint_subresource_name != "" ? [var.private_endpoint_subresource_name] : null
    
    }

    tags = var.tags

    lifecycle {
      prevent_destroy = true

      ignore_changes = [
          name, 
          location,
          resource_group_name,
          subnet_id,
          private_service_connection,
          tags
        ]
    }
}
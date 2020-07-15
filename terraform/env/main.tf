provider "azurerm" {
  version = "=1.35.0"
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Create a resource group
resource "azurerm_resource_group" "hadoop" {
  name     = var.rg
  location = var.location
}

resource "azurerm_availability_set" "avsetdev" {
  name                = "avsetdev"
  location            = azurerm_resource_group.hadoop.location
  resource_group_name = azurerm_resource_group.hadoop.name
  platform_fault_domain_count  = 3
  platform_update_domain_count = 10
  managed                      = true
  tags = {
    environment = "dev"
  }
}

resource "azurerm_availability_set" "avsetsit" {
  name                = "avsetsit"
  location            = azurerm_resource_group.hadoop.location
  resource_group_name = azurerm_resource_group.hadoop.name
  platform_fault_domain_count  = 3
  platform_update_domain_count = 10
  managed                      = true
  tags = {
    environment = "sit"
  }
}

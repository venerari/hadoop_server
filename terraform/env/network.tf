# network
resource "azurerm_virtual_network" "hadoop-network" {
  name                = "hadoop-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.hadoop.name
  address_space       = ["10.0.0.0/16"]
}

# subnet
resource "azurerm_subnet" "subnetdev" {
  name                 = "subnetdev"
  resource_group_name  = azurerm_resource_group.hadoop.name
  virtual_network_name = azurerm_virtual_network.hadoop-network.name
  address_prefix       = "10.0.0.0/24"
}

resource "azurerm_subnet" "subnetsit" {
  name                 = "subnetsit"
  resource_group_name  = azurerm_resource_group.hadoop.name
  virtual_network_name = azurerm_virtual_network.hadoop-network.name
  address_prefix       = "10.0.10.0/24"
}

resource "azurerm_network_security_group" "hdmas1dev-ssh" {
    name                = "hdmas1dev-ssh"
    location            = var.location
    resource_group_name = azurerm_resource_group.hadoop.name

    security_rule {
        name                       = "SSH"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = var.ssh-source-address
        destination_address_prefix = "*"
    }
}
 
resource "azurerm_network_security_group" "hdmas1sit-ssh" {
    name                = "hdmas1sit-ssh"
    location            = var.location
    resource_group_name = azurerm_resource_group.hadoop.name

    security_rule {
        name                       = "SSH"
        priority                   = 1011
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = var.ssh-source-address
        destination_address_prefix = "*"
    }
} 

resource "azurerm_network_security_group" "agent1-ssh" {
    name                = "agent1-ssh"
    location            = var.location
    resource_group_name = azurerm_resource_group.hadoop.name

    security_rule {
        name                       = "SSH"
        priority                   = 910
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = var.ssh-source-address
        destination_address_prefix = "*"
    }
}

resource "azurerm_network_security_group" "agent2-ssh" {
    name                = "agent2-ssh"
    location            = var.location
    resource_group_name = azurerm_resource_group.hadoop.name

    security_rule {
        name                       = "SSH"
        priority                   = 911
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = var.ssh-source-address
        destination_address_prefix = "*"
    }
}

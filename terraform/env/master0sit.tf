
# hadoop hdmas1sit instance
resource "azurerm_virtual_machine" "hdmas1sit" {
  name                  = "hdmas1sit"
  location              = var.location
  availability_set_id   = azurerm_availability_set.avsetsit.id
  resource_group_name   = azurerm_resource_group.hadoop.name
  network_interface_ids = [azurerm_network_interface.hdmas1sit.id]
  vm_size               = "Standard_B4ms"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.6"
    version   = "latest"
  }
  storage_os_disk {
    name              = "hdmas1sitdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }
  os_profile {
    computer_name  = "hdmas1sit"
    admin_username = "azure"
    admin_password = "Clark@12345!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "hdmas1sit" {
  name                      = "hdmas1sit"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.hadoop.name
  network_security_group_id = azurerm_network_security_group.hdmas1sit-ssh.id

  ip_configuration {
    name                          = "hdmas1sit"
    subnet_id                     = azurerm_subnet.subnetsit.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.0.10.11"
    public_ip_address_id          = azurerm_public_ip.hdmas1sit-public-ip1.id
  }
}

resource "azurerm_public_ip" "hdmas1sit-public-ip1" {
    name                         = "hdmas1sit-public-ip1"
    location                     = var.location
    resource_group_name          = azurerm_resource_group.hadoop.name
    allocation_method            = "Dynamic"
}

resource "azurerm_virtual_machine_extension" "hdmas1sit-script" {
  name                 = "hdmas1sit-script"
  location             = var.location
  resource_group_name  = azurerm_resource_group.hadoop.name
  virtual_machine_name = azurerm_virtual_machine.hdmas1sit.name
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"
  auto_upgrade_minor_version = "true"

  settings = <<SETTINGS
    {
       "fileUris": ["https://donotdeletetfstate.blob.core.windows.net/binary/script1.sh"],
       "commandToExecute": "sh script1.sh"    }
SETTINGS

}

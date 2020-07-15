
# hadoop hdspk2sit instance
resource "azurerm_virtual_machine" "hdspk2sit" {
  name                  = "hdspk2sit"
  location              = var.location
  availability_set_id   = azurerm_availability_set.avsetsit.id
  resource_group_name   = azurerm_resource_group.hadoop.name
  network_interface_ids = [azurerm_network_interface.hdspk2sit.id]
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
    name              = "hdspk2sitdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }
  os_profile {
    computer_name  = "hdspk2sit"
    admin_username = "azure"
    admin_password = "Clark@12345!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "hdspk2sit" {
  name                      = "hdspk2sit"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.hadoop.name

  ip_configuration {
    name                          = "hdspk2sit"
    subnet_id                     = azurerm_subnet.subnetsit.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.0.10.17"
  }
}

resource "azurerm_virtual_machine_extension" "hdspk2sit-script" {
  name                 = "hdspk2sit-script"
  location             = var.location
  resource_group_name  = azurerm_resource_group.hadoop.name
  virtual_machine_name = azurerm_virtual_machine.hdspk2sit.name
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

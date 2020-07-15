
# hadoop dbdev instance
resource "azurerm_virtual_machine" "dbdev" {
  name                  = "dbdev"
  location              = var.location
  availability_set_id   = azurerm_availability_set.avsetdev.id
  resource_group_name   = azurerm_resource_group.hadoop.name
  network_interface_ids = [azurerm_network_interface.dbdev.id]
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
    name              = "dbdevdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }
  storage_data_disk {
    name              = "dbdevdisk2"
    lun = 1
    managed_disk_type = "Premium_LRS"
    create_option = "Empty"
    disk_size_gb = 30
    caching           = "ReadWrite"
  }
  os_profile {
    computer_name  = "dbdev"
    admin_username = "azure"
    admin_password = "Clark@12345!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "dbdev" {
  name                      = "dbdev"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.hadoop.name

  ip_configuration {
    name                          = "dbdev"
    subnet_id                     = azurerm_subnet.subnetdev.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.0.0.6"
  }
}


resource "azurerm_virtual_machine_extension" "dbdev-script" {
  name                 = "dbdev-script"
  location             = var.location
  resource_group_name  = azurerm_resource_group.hadoop.name
  virtual_machine_name = azurerm_virtual_machine.dbdev.name
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
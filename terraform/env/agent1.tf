
# hadoop agent1 instance
resource "azurerm_virtual_machine" "agent1" {
  name                  = "agent1"
  location              = var.location
  availability_set_id   = azurerm_availability_set.avsetdev.id
  resource_group_name   = azurerm_resource_group.hadoop.name
  network_interface_ids = [azurerm_network_interface.agent1.id]
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
    name              = "agent1disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }
  storage_data_disk {
    name              = "agent1disk2"
    lun = 1
    managed_disk_type = "Premium_LRS"
    create_option = "Empty"
    disk_size_gb = 30
    caching           = "ReadWrite"
  }
  os_profile {
    computer_name  = "agent1"
    admin_username = "azure"
    admin_password = "Clark@12345!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "agent1" {
  name                      = "agent1"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.hadoop.name
  network_security_group_id = azurerm_network_security_group.agent1-ssh.id

  ip_configuration {
    name                          = "agent1"
    subnet_id                     = azurerm_subnet.subnetdev.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.0.0.5"
    public_ip_address_id          = azurerm_public_ip.agent1-public-ip1.id
  }
}


resource "azurerm_public_ip" "agent1-public-ip1" {
    name                         = "agent1-public-ip1"
    location                     = var.location
    resource_group_name          = azurerm_resource_group.hadoop.name
    allocation_method            = "Dynamic"
}

resource "azurerm_virtual_machine_extension" "agent1-script" {
  name                 = "agent1-script"
  location             = var.location
  resource_group_name  = azurerm_resource_group.hadoop.name
  virtual_machine_name = azurerm_virtual_machine.agent1.name
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

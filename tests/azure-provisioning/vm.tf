resource "azurerm_network_interface" "nic" {
  count = var.vm_count

  name                = "nic-vault-vm-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip[count.index].id
  }

  tags = var.tags
}


resource "azurerm_virtual_machine" "main" {
  count = var.vm_count

  name                  = "vault-vm-${count.index}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "erockyenterprisesoftwarefoundationinc1653071250513"
    offer     = "rockylinux-9"
    sku       = "rockylinux-9"
    version = "latest"
  }
  storage_os_disk {
    name              = "os-disk-vm-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "vault-node-${count.index}"
    admin_username = "vault"
    admin_password = "Vault123!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  plan {
    name = "rockylinux-9"
    publisher = "erockyenterprisesoftwarefoundationinc1653071250513"
    product = "rockylinux-9"
  }
  tags = var.tags
}
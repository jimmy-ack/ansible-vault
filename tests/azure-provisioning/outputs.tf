output "vm_private_ip_addresses" {
    description = "Vault servers private ip addresses"
  value = [ for nic in azurerm_network_interface.nic: nic.private_ip_address ] 
}

output "vm_public_ip_addresses" {
    description = "Vault servers public ip addresses"
  value = [ for pip in azurerm_public_ip.public_ip: pip.ip_address ] 
}
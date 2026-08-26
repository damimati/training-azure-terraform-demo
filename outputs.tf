# Create Output for Resource Group name after deployment

output "resource_group_name" {
  value       = azurerm_resource_group.mati_own_rg1.name
  description = "The name of the resource group"
}

# Create Output for storage account name after deployment
/*output "storage_account_endpoint" {
  value       = azurerm_storage_account.mati_own_storageacct.primary_blob_endpoint
  description = "Blob endpoint for the storage account"
}*/

/*output "storage_account_name" {
  value       = azurerm_storage_account.mati_own_storageacct.name
  description = "Storage account name"
}*/

# Create Output for list of subnets that RT is associated to
output "RT_db_Subnet_Association" {
  value = azurerm_subnet_route_table_association.mati_own_db_rt_asso.subnet_id
}

output "RT_app_Subnet_Association" {
  value = azurerm_subnet_route_table_association.mati_own_app_rt_asso.subnet_id
}

output "RT_web_Subnet_Association" {
  value = azurerm_subnet_route_table_association.mati_own_web_rt_asso.subnet_id
}


output "Virtual_Network_Name_01" {
  value = azurerm_virtual_network.mati_own_vnet_name.name
  description = "This is the name of vnet 01"
}

output "Virtual_Network_Name_02" {
  value = azurerm_virtual_network.mati_own_vnet_name-02.name
  description = "This is the name of vnet 02"
}

/*output "Virtual_Machine_Name" {
  value = azurerm_linux_virtual_machine.mati_own_linux_vm.name
  description = "This is the name of Vitrual Machine"
}*/

/*output "Virtual_Machine_IP" {
  value = azurerm_network_interface.mati_own_inc.private_ip_address
  description = "This is the private IP of Vitrual Machine"
}*/

/*output "Virtual_Machine_Name_and_IP" {
  value = {
    for k, vm in azurerm_linux_virtual_machine.mati_own_linux_vm :
    k => {
      vm_name    = vm.name
      private_ip = azurerm_network_interface.mati_own_inc[k].private_ip_address
    }
  }
}*/
# Create Resource Group 
resource "azurerm_resource_group" "mati_own_rg1" {
  location = local.location
  name = var.resource_group_name
  tags = local.common_tags
}

# Create Storage Account
/*resource "azurerm_storage_account" "mati_own_storageacct" {
  name                     = local.storage_name
  resource_group_name      = azurerm_resource_group.mati_own_rg1.name
  location                 = azurerm_resource_group.mati_own_rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  public_network_access_enabled = false
  allow_nested_items_to_be_public = false
  tags = local.common_tags
}*/

# Create Virtual Network
resource "azurerm_virtual_network" "mati_own_vnet_name" {
  name = "${local.generic_name}-${var.vnet_name}"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  location = azurerm_resource_group.mati_own_rg1.location
  tags = local.common_tags
  address_space = var.address_space
}


#Create Virtual Network 02
resource "azurerm_virtual_network" "mati_own_vnet_name-02" {
  name = "${local.generic_name}-${var.vnet_name-02}"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  location = azurerm_resource_group.mati_own_rg1.location
  tags = local.common_tags
  address_space = var.address_space-02
  dns_servers = var.dns_servers

}


# Create App Subnet
resource "azurerm_subnet" "mati_own_appsubnet" {
  name = "${local.generic_name}-${var.appsubnet}"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  virtual_network_name = azurerm_virtual_network.mati_own_vnet_name.name
  address_prefixes = var.address_space_appsubnet
}

# Create Web Subnet
resource "azurerm_subnet" "mati_own_websubnet" {
  name = "${local.generic_name}-${var.websubnet}"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  virtual_network_name = azurerm_virtual_network.mati_own_vnet_name.name
  address_prefixes = var.address_space_websubnet
}

# Create DB Subnet
resource "azurerm_subnet" "mati_own_dbsubnet" {
  name = "${local.generic_name}-${var.dbsubnet}"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  virtual_network_name = azurerm_virtual_network.mati_own_vnet_name.name
  address_prefixes = var.address_space_dbsubnet
}


# Create App Subnet02
resource "azurerm_subnet" "mati_own_appsubnet02" {
  name = "${local.generic_name}-${var.appsubnet02}"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  virtual_network_name = azurerm_virtual_network.mati_own_vnet_name-02.name
  address_prefixes = var.address_space_appsubnet02
}

# Create Web Subnet02
resource "azurerm_subnet" "mati_own_websubnet02" {
  name = "${local.generic_name}-${var.websubnet02}"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  virtual_network_name = azurerm_virtual_network.mati_own_vnet_name-02.name
  address_prefixes = var.address_space_websubnet02
}

# Create DB Subnet02
resource "azurerm_subnet" "mati_own_dbsubnet02" {
  name = "${local.generic_name}-${var.dbsubnet02}"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  virtual_network_name = azurerm_virtual_network.mati_own_vnet_name-02.name
  address_prefixes = var.address_space_dbsubnet02
}

# Create Bastion Subnet
resource "azurerm_subnet" "mati_own_bastionsubnet" {
  name = "AzureBastionSubnet"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  virtual_network_name = azurerm_virtual_network.mati_own_vnet_name-02.name
  address_prefixes = var.address_space_bastionsubnet
}

/*#Create public IP for bastion config
resource "azurerm_public_ip" "mati_own_bastionpip" {
  name                = "${local.generic_name}-bastionpip"
  location            = azurerm_resource_group.mati_own_rg1.location
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  allocation_method   = "Static"
  sku                 = "Standard"
}*/


# Create Bastion Host
/*resource "azurerm_bastion_host" "mati_own_bastionhost" {
  name = "${local.generic_name}-bastion"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  location = azurerm_resource_group.mati_own_rg1.location
  copy_paste_enabled = true
  sku = "Basic"

  ip_configuration {
    name = "mati_ipconfig"
    subnet_id = azurerm_subnet.mati_own_bastionsubnet.id
    public_ip_address_id = azurerm_public_ip.mati_own_bastionpip.id
    
  }
}*/

# Create Gateway Subnet for express route integration
resource "azurerm_subnet" "GatewaySubnet" {
  name = "GatewaySubnet"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  virtual_network_name = azurerm_virtual_network.mati_own_vnet_name-02.name
  address_prefixes = var.address_space_gatewaysubnet
}


# Create App NSG
resource "azurerm_network_security_group" "mati_own_appnsg"{
  name = "${azurerm_subnet.mati_own_appsubnet.name}-nsg"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  location = azurerm_resource_group.mati_own_rg1.location

  security_rule {
    name = "Allow_All"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix = "*"

  }
}

# Create DB NSG
resource "azurerm_network_security_group" "mati_own_dbnsg"{
  name = "${azurerm_subnet.mati_own_dbsubnet.name}-nsg"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  location = azurerm_resource_group.mati_own_rg1.location

  security_rule {
    name = "Allow_All"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix = "*"

  }
}

# Create Web NSG
resource "azurerm_network_security_group" "mati_own_webnsg"{
  name = "${azurerm_subnet.mati_own_websubnet.name}-nsg"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  location = azurerm_resource_group.mati_own_rg1.location

  security_rule {
    name = "Allow_All"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix = "*"

  }
}

# Create App Subnet and Nsg Association
resource "azurerm_subnet_network_security_group_association" "mati_own_appnsg_asso"{
  subnet_id = azurerm_subnet.mati_own_appsubnet.id
  network_security_group_id = azurerm_network_security_group.mati_own_appnsg.id
}

# Create DB Subnet and Nsg Association
resource "azurerm_subnet_network_security_group_association" "mati_own_dbnsg_asso"{
  subnet_id = azurerm_subnet.mati_own_dbsubnet.id
  network_security_group_id = azurerm_network_security_group.mati_own_dbnsg.id
}

# Create Web Subnet and Nsg Association
resource "azurerm_subnet_network_security_group_association" "mati_own_webnsg_asso"{
  subnet_id = azurerm_subnet.mati_own_websubnet.id
  network_security_group_id = azurerm_network_security_group.mati_own_webnsg.id
}


# Create Generic RT for app and web subnet
resource "azurerm_route_table" "mati_own_gen_rt" {
  name                = "RT-${local.generic_name}"
  location            = azurerm_resource_group.mati_own_rg1.location
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  bgp_route_propagation_enabled = false

  route {
    name           = "specific_route"
    address_prefix = "100.2.4.3/32"
    next_hop_type  = "Internet"
  }


}

# Create  RT for db subnet
resource "azurerm_route_table" "mati_own_db_rt" {
  name                = "RT-${azurerm_subnet.mati_own_dbsubnet.name}"
  location            = azurerm_resource_group.mati_own_rg1.location
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  bgp_route_propagation_enabled = false

  route {
    name           = "specific_route"
    address_prefix = "99.2.4.3/32"
    next_hop_type  = "VnetLocal"
  }


}


# Create Association for generic RT to app subnet
resource "azurerm_subnet_route_table_association" "mati_own_app_rt_asso" {
  subnet_id = azurerm_subnet.mati_own_appsubnet.id
  route_table_id = azurerm_route_table.mati_own_gen_rt.id
}

# Create Association for generic RT to web subnet
resource "azurerm_subnet_route_table_association" "mati_own_web_rt_asso" {
  subnet_id = azurerm_subnet.mati_own_websubnet.id
  route_table_id = azurerm_route_table.mati_own_gen_rt.id
}

# Create Association for generic RT to db subnet
resource "azurerm_subnet_route_table_association" "mati_own_db_rt_asso" {
  subnet_id = azurerm_subnet.mati_own_dbsubnet.id
  route_table_id = azurerm_route_table.mati_own_db_rt.id
}

# Create vnet peering for vnet01 to vnet02
resource "azurerm_virtual_network_peering" "mati_own_peering01to02" {
  name                      = "${local.generic_name}-peering-vnet01tovnet02"
  resource_group_name       = azurerm_resource_group.mati_own_rg1.name
  virtual_network_name      = azurerm_virtual_network.mati_own_vnet_name.name
  remote_virtual_network_id = azurerm_virtual_network.mati_own_vnet_name-02.id
  allow_virtual_network_access = true
  use_remote_gateways = false
  allow_forwarded_traffic = true
  allow_gateway_transit = false

  #depends_on = [ azurerm_virtual_network_gateway.mati_own_vnet02_gw ]
}

# Create vnet peering for vnet02 to vnet01
resource "azurerm_virtual_network_peering" "mati_own_peering02to01" {
  name                      = "${local.generic_name}-peering-vnet02tovnet01"
  resource_group_name       = azurerm_resource_group.mati_own_rg1.name
  virtual_network_name      = azurerm_virtual_network.mati_own_vnet_name-02.name
  remote_virtual_network_id = azurerm_virtual_network.mati_own_vnet_name.id
  allow_virtual_network_access = true
  use_remote_gateways = false
  allow_forwarded_traffic =  true
  allow_gateway_transit = false
}



/*#Create the public IP for the gateway 
resource "azurerm_public_ip" "mati_own_vnet02_gw_pip" {
  name                = "${local.generic_name}-vnet02-gw-pip"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  location            = azurerm_resource_group.mati_own_rg1.location
  allocation_method   = "Static"
  sku                 = "Standard"
  zones = ["1"]
}

#Create the network gateway on vnet02
resource "azurerm_virtual_network_gateway" "mati_own_vnet02_gw" {
  name                = "${local.generic_name}-vnet02-gw"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  location            = azurerm_resource_group.mati_own_rg1.location
  type     = "Vpn"          # or "ExpressRoute"
  vpn_type = "RouteBased"
  active_active = false
  bgp_enabled    = false
  sku           = "VpnGw1AZ"
 

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id         = azurerm_public_ip.mati_own_vnet02_gw_pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.GatewaySubnet.id
  }
}*/

#Create a Linux VM with private IP only (Username & Password; and SSH Key)
#First create a network interface

/*resource "azurerm_public_ip" "mati_own_nic_pip" { //Public Ip for the VMs to be created
  for_each = var.vm_to_create
  name                = "${local.vm_name_lx}-${each.value}pip"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  location            = azurerm_resource_group.mati_own_rg1.location
  allocation_method   = "Static"
  sku                 = "Standard"
  zones = ["1"]
}*/

/*resource "azurerm_network_interface" "mati_own_inc" { //Use this to create multiple nic card instead of duplicating the block
  for_each = var.vm_to_create //This will create the number of instances declared in the varible vm_to_create look within the terraform.tfvars file
  name = "${local.vm_name_lx}-${each.value}nic" //This iterates over the vm_to_create map declared and passes the value (key:value)
  location = azurerm_resource_group.mati_own_rg1.location
  resource_group_name = azurerm_resource_group.mati_own_rg1.name

  ip_configuration {
    name = "private_ip"
    subnet_id = azurerm_subnet.mati_own_websubnet.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id = azurerm_public_ip.mati_own_nic_pip[each.key].id //public ip association to the created nic interfaces
  }

}*/



/*#Create a Linux VM with private IP only (Username & Password; and SSH Key)
#First create a network interface
resource "azurerm_network_interface" "mati_own_inc" {
  name = "${local.vm_name_lx}-nic"
  location = azurerm_resource_group.mati_own_rg1.location
  resource_group_name = azurerm_resource_group.mati_own_rg1.name

  ip_configuration {
    name = "private_ip"
    subnet_id = azurerm_subnet.mati_own_websubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
#For Redhat you have to accept Microsoft terms and conditions before deploying the redhat

resource "azurerm_marketplace_agreement" "rhel_terms" {
  publisher = "RedHat"
  offer     = "RHEL"
  plan      = "9-lvm-gen2"
}*/

#Next create the vm

//Use this to create multiple VMs of the same SKU and Spec instead of duplicating the block

/*resource "azurerm_linux_virtual_machine" "mati_own_linux_vm"{ //Linux VM
  for_each = var.vm_to_create
  name = "${local.vm_name_lx}-${each.value}"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  location = azurerm_resource_group.mati_own_rg1.location
  computer_name = "${local.vm_name_lx}-${each.value}"
  network_interface_ids = [azurerm_network_interface.mati_own_inc[each.key].id]
  size = "Standard_DS1_v2"
  admin_username = "mati_admin"
  admin_password = var.admin_password
  disable_password_authentication = false //set this to true if you want to use ssh keys and false to use password
  tags = local.common_tags

  /*admin_ssh_key {
    username   = "mati_admin"
    public_key = file(var.ssh_pubkey_path) //file is a terraform syntax used to copy the content 
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
	disk_size_gb = 150
	name = "${local.vm_name_lx}-${each.value}os_disk"
	
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "9-lvm-gen2"
    version   = "latest"
  }

  boot_diagnostics {
    
  }


#depends_on = [ azurerm_marketplace_agreement.rhel_terms ] #This is stating that the vm will be created after terraform first accepts the Microsoft terms and condition for RHEL

}*/

#Create a managed disk for a second drive for the VM and attach it to the VM
/*resource "azurerm_managed_disk" "mati_own_data_disk" {
  for_each = var.vm_to_create
  name = "${local.vm_name_lx}-datadisk${each.value}"
  location = azurerm_resource_group.mati_own_rg1.location
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  disk_size_gb = 200
  create_option = "Empty"
  storage_account_type = "Standard_LRS"
    
}

#Attached the data disk to the VM
resource "azurerm_virtual_machine_data_disk_attachment" "mati_own_data_disk_attach"{
  for_each = var.vm_to_create
  managed_disk_id = azurerm_managed_disk.mati_own_data_disk[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.mati_own_linux_vm[each.key].id
  lun = 0
  caching = "ReadWrite"
}*/


//Use this to create multiple VMs of the same SKU and Spec instead of duplicating the block

/*resource "azurerm_network_interface" "mati_own_inc_02" { //Use this to create multiple nic card instead of duplicating the block
  for_each = var.vm_to_create //This will create the number of instances declared in the varible vm_to_create look within the terraform.tfvars file
  name = "${local.vm_name_win}-${each.value}nic" //This iterates over the vm_to_create map declared and passes the value (key:value)
  location = azurerm_resource_group.mati_own_rg1.location
  resource_group_name = azurerm_resource_group.mati_own_rg1.name

  ip_configuration {
    name = "private_ip"
    subnet_id = azurerm_subnet.mati_own_appsubnet.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id = azurerm_public_ip.mati_own_nic_pip[each.key].id //public ip association to the created nic interfaces
  }

}*/
/*resource "azurerm_windows_virtual_machine" "mati_own_win_vm"{ //Windows VM
  for_each = var.vm_to_create
  name = "${local.vm_name_win}-${each.value}"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  location = azurerm_resource_group.mati_own_rg1.location
  computer_name = "az-matiapp-${each.value}"
  network_interface_ids = [azurerm_network_interface.mati_own_inc_02[each.key].id]
  size = "Standard_DS1_v2"
  admin_username = "mati_admin"
  admin_password = var.admin_password
  tags = local.common_tags

  /*admin_ssh_key {
    username   = "mati_admin"
    public_key = file(var.ssh_pubkey_path) //file is a terraform syntax used to copy the content 
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
	disk_size_gb = 150
	name = "${local.vm_name_win}-${each.value}os_disk"
	
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  boot_diagnostics {
    
  }


#depends_on = [ azurerm_marketplace_agreement.rhel_terms ] #This is stating that the vm will be created after terraform first accepts the Microsoft terms and condition for RHEL

}*/

/*#Create a managed disk for a second drive for the VM and attach it to the VM
resource "azurerm_managed_disk" "mati_own_data_disk_win" {
  for_each = var.vm_to_create
  name = "${local.vm_name_win}-datadisk${each.value}"
  location = azurerm_resource_group.mati_own_rg1.location
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  disk_size_gb = 200
  create_option = "Empty"
  storage_account_type = "Standard_LRS"
    
}*/

/*#Attached the data disk to the VM
resource "azurerm_virtual_machine_data_disk_attachment" "mati_own_data_disk_attach_win"{
  for_each = var.vm_to_create
  managed_disk_id = azurerm_managed_disk.mati_own_data_disk_win[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.mati_own_win_vm[each.key].id
  lun = 0
  caching = "ReadWrite"
}*/

/*resource "azurerm_linux_virtual_machine" "mati_own_linux_vm"{ // This is for a single VM deployment
  name = "${local.vm_name_lx}-01"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  location = azurerm_resource_group.mati_own_rg1.location
  computer_name = "${local.vm_name_lx}-01"
  network_interface_ids = [azurerm_network_interface.mati_own_inc.id]
  size = "Standard_B2ls_v2"
  admin_username = "mati_admin"
  #admin_password = var.admin_password
  disable_password_authentication = true //set this to true if you want to use ssh keys and false to use password
  tags = local.common_tags

   admin_ssh_key {
    username   = "mati_admin"
    public_key = file(var.ssh_pubkey_path) //file is a terraform syntax used to copy the content 
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
	disk_size_gb = 150
	name = "${local.vm_name_lx}-os_disk"
	
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "9-lvm-gen2"
    version   = "latest"
  }

  boot_diagnostics {
    
  }


depends_on = [ azurerm_marketplace_agreement.rhel_terms ] #This is stating that the vm will be created after terraform first accepts the Microsoft terms and condition for RHEL

}*/

/*#Create a managed disk for a second drive for the VM and attach it to the VM
resource "azurerm_managed_disk" "mati_own_data_disk" {
  name = "${local.vm_name_lx}-datadisk01"
  location = azurerm_resource_group.mati_own_rg1.location
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  disk_size_gb = 200
  create_option = "Empty"
  storage_account_type = "Standard_LRS"
    
}*/

/*#Attached the data disk to the VM
resource "azurerm_virtual_machine_data_disk_attachment" "mati_own_data_disk_attach"{
  managed_disk_id = azurerm_managed_disk.mati_own_data_disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.mati_own_linux_vm.id
  lun = 0
  caching = "ReadWrite"
}*/


/*#Use this to create a single nic deployment for a single vm
resource "azurerm_network_interface" "mati_own_inc_02" { //Use this to create a single nic deployment for a single vm
  name = "${local.vm_name_win}-01nic" //This iterates over the vm_to_create map declared and passes the value (key:value)
  location = azurerm_resource_group.mati_own_rg1.location
  resource_group_name = azurerm_resource_group.mati_own_rg1.name

  ip_configuration {
    name = "private_ip"
    subnet_id = azurerm_subnet.mati_own_appsubnet.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id = azurerm_public_ip.mati_own_nic_pip[each.key].id //public ip association to the created nic interfaces
  }

}
resource "azurerm_windows_virtual_machine" "mati_own_win_vm"{ //Windows VM Single Creation
  name = "${local.vm_name_win}-01"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  location = azurerm_resource_group.mati_own_rg1.location
  computer_name = "az-matiapp-01"
  network_interface_ids = [azurerm_network_interface.mati_own_inc_02.id]
  size = "Standard_DS1_v2"
  admin_username = "mati_admin"
  admin_password = var.admin_password
  tags = local.common_tags

  admin_ssh_key {
    username   = "mati_admin"
    public_key = file(var.ssh_pubkey_path) //file is a terraform syntax used to copy the content 
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
	disk_size_gb = 150
	name = "${local.vm_name_win}-01os_disk"
	
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  boot_diagnostics {
    
  }


#depends_on = [ azurerm_marketplace_agreement.rhel_terms ] #This is stating that the vm will be created after terraform first accepts the Microsoft terms and condition for RHEL

}


resource "azurerm_virtual_machine_extension" "mati_own_install_iis" { //This enables iis within the windows server deployment 
  name = "install-iis"
  virtual_machine_id = azurerm_windows_virtual_machine.mati_own_win_vm.id
  publisher = "Microsoft.Compute"
  type = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = jsonencode({
    commandToExecute = "powershell -Command \"Install-WindowsFeature -Name Web-Server -IncludeManagementTools\""
  })

  depends_on = [azurerm_windows_virtual_machine.mati_own_win_vm ]
}*/

//Using the count meta argument to deploy 

/*resource "azurerm_network_interface" "mati_own_inc_02" { //Use this to create multiple nic deployment with count meta argument
  count = 3
  name = "${local.vm_name_win}-${count.index}nic" //This iterates over the number defined in the count meta arguement
  location = azurerm_resource_group.mati_own_rg1.location
  resource_group_name = azurerm_resource_group.mati_own_rg1.name

  ip_configuration {
    name = "private_ip"
    subnet_id = azurerm_subnet.mati_own_appsubnet.id
    private_ip_address_allocation = "Dynamic"
  }

}
resource "azurerm_windows_virtual_machine" "mati_own_win_vm"{ //Windows VM multiple deployment
  count = 3
  name = "${local.vm_name_win}-${count.index}"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  location = azurerm_resource_group.mati_own_rg1.location
  computer_name = "az-matiapp-${count.index}"
  network_interface_ids = [azurerm_network_interface.mati_own_inc_02[count.index].id]
  size = "Standard_DS1_v2"
  admin_username = "mati_admin"
  admin_password = var.admin_password
  tags = local.common_tags

  admin_ssh_key {
    username   = "mati_admin"
    public_key = file(var.ssh_pubkey_path) //file is a terraform syntax used to copy the content 
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
	disk_size_gb = 150
	name = "${local.vm_name_win}-${count.index}os_disk"
	
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  boot_diagnostics {
    
  }


#depends_on = [ azurerm_marketplace_agreement.rhel_terms ] #This is stating that the vm will be created after terraform first accepts the Microsoft terms and condition for RHEL

}*/

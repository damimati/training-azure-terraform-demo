/*#Create public IP for loadbalancer
resource "azurerm_public_ip" "mati_own_lbpip" {
  name                = "${local.generic_name}lbpip"
  location            = azurerm_resource_group.mati_own_rg1.location
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  allocation_method   = "Static"
  sku = "Standard"
}
#Create Loadbalancer and frontend IP for loadbalancer
resource "azurerm_lb" "mati_own_lb" {
  name                = "${local.generic_name}-lb"
  location            = azurerm_resource_group.mati_own_rg1.location
  resource_group_name = azurerm_resource_group.mati_own_rg1.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.mati_own_lbpip.id
  }
}

# Resource-3: Create LB Backend Pool
resource "azurerm_lb_backend_address_pool" "mati_own_bkendpool" {
  name = "web-backend"
  loadbalancer_id = azurerm_lb.mati_own_lb.id
}
# Resource-4: Create LB Probe
resource "azurerm_lb_probe" "mati_own_lbprobe" {
  name = "tcp-probe"
  protocol = "Tcp"
  port = 80
  loadbalancer_id = azurerm_lb.mati_own_lb.id
  
}
# Resource-5: Create LB Rule
resource "azurerm_lb_rule" "web_lb_rule_app1" {
  name = "web-app1-rule"
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 80
  frontend_ip_configuration_name = azurerm_lb.mati_own_lb.frontend_ip_configuration[0].name
  probe_id = azurerm_lb_probe.mati_own_lbprobe.id 
  loadbalancer_id = azurerm_lb.mati_own_lb.id
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.mati_own_bkendpool.id ]
}

# Resource-6: Associate Network Interface and Standard Load Balancer
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_backend_address_pool_association
resource "azurerm_network_interface_backend_address_pool_association" "web_nic_lb_associate" {
  network_interface_id = azurerm_network_interface.mati_own_inc_02.id 
  ip_configuration_name = azurerm_network_interface.mati_own_inc_02.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.mati_own_bkendpool.id  

  depends_on = [ azurerm_windows_virtual_machine.mati_own_win_vm ]
  
}

#Create the LB NAT rule
resource "azurerm_lb_nat_rule" "mati_own_lbnat" {
  resource_group_name            = azurerm_resource_group.mati_own_rg1.name
  loadbalancer_id                = azurerm_lb.mati_own_lb.id
  name                           = "RDPAccess"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = azurerm_lb.mati_own_lb.frontend_ip_configuration[0].name
}

#Associate the LB NAT Rule to the VM
resource "azurerm_network_interface_nat_rule_association" "mati_own_nic_natassoc" {
  network_interface_id = azurerm_network_interface.mati_own_inc_02.id
  ip_configuration_name = "private_ip" # must match the ip_configuration name inside your NIC block
  nat_rule_id           = azurerm_lb_nat_rule.mati_own_lbnat.id
}*/
/*resource "azurerm_resource_group" "mati_rsv" {
  name     = "mati-recovery_vault"
  location = local.location
}

resource "azurerm_recovery_services_vault" "mati_vault" {
  name                = "mati-vault"
  location            = local.location
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
  sku                 = "Standard"

  public_network_access_enabled = false

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_private_endpoint" "mati_own_recovery_vault"{
    name = "pe-mati_vault"
    location = local.location
    resource_group_name = azurerm_resource_group.mati_own_rg1.name

    subnet_id = azurerm_subnet.mati_own_backupsubnet.id

    private_dns_zone_group {
    name                 = "backup-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.mati_own_backup_pdns.id]
  }

    private_service_connection {
      name = "psc-mati_vault"
      private_connection_resource_id = azurerm_recovery_services_vault.mati_vault.id

      subresource_names = [ 
        "AzureBackup"
       ]

       is_manual_connection = false
    }
}

resource "azurerm_private_dns_zone" "mati_own_backup_pdns" {
  name                = "privatelink.san.backup.windowsazure.com"
  resource_group_name = azurerm_resource_group.mati_own_rg1.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "mati_own_backup_pdns" {
  name                  = "link-backup"
  resource_group_name   = azurerm_resource_group.mati_own_rg1.name
  private_dns_zone_name = azurerm_private_dns_zone.mati_own_backup_pdns.name
  virtual_network_id    = azurerm_virtual_network.mati_own_vnet_name.id   # your actual VNet resource name
  registration_enabled  = false
}
*/

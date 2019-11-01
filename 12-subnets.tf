
resource "azurerm_subnet" "subnet-mgmt" {
  name                                = "dmz-mgmt"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  virtual_network_name                = "${azurerm_virtual_network.vnet_dmz.name}"
  address_prefix                      = "${var.subnet-mgmt-prefix}"
  network_security_group_id           = "${azurerm_network_security_group.nsg_mgmt.id}"
  lifecycle { 
     ignore_changes                 = ["route_table_id"]
 }

}

resource "azurerm_subnet" "subnet-dmz-loadbalancer" {
  name                                = "dmz-loadbalancer"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  virtual_network_name                = "${azurerm_virtual_network.vnet_dmz.name}"
  address_prefix                      = "${var.subnet-dmz-loadbalancer-prefix}"
  network_security_group_id           = "${azurerm_network_security_group.nsg_loadbalancer.id}"
  lifecycle { 
     ignore_changes                 = ["route_table_id"]
 }

}


resource "azurerm_subnet" "subnet-dmz-palo-public" {
  name                                = "dmz-palo-public"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  virtual_network_name                = "${azurerm_virtual_network.vnet_dmz.name}"
  address_prefix                      = "${var.subnet-dmz-palo-public-prefix}"
  network_security_group_id           = "${azurerm_network_security_group.nsg_palo_public.id}"
  lifecycle { 
     ignore_changes                 = ["route_table_id"]
 }

}

resource "azurerm_subnet" "subnet-dmz-palo-private" {
  name                                = "dmz-palo-private"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  virtual_network_name                = "${azurerm_virtual_network.vnet_dmz.name}"
  address_prefix                      = "${var.subnet-dmz-palo-private-prefix}"
  network_security_group_id           = "${azurerm_network_security_group.nsg_palo_private.id}"
  lifecycle { 
     ignore_changes                 = ["route_table_id"]
 }

}



resource "azurerm_subnet_network_security_group_association" "nsg_mgmt" {
  subnet_id                           = "${azurerm_subnet.subnet-mgmt.id}"
  network_security_group_id           = "${azurerm_network_security_group.nsg_mgmt.id}"
}

resource "azurerm_subnet_network_security_group_association" "nsg_loadbalancer" {
  subnet_id                           = "${azurerm_subnet.subnet-dmz-loadbalancer.id}"
  network_security_group_id           = "${azurerm_network_security_group.nsg_loadbalancer.id}"
}


resource "azurerm_subnet_network_security_group_association" "nsg_palo_public" {
  subnet_id                           = "${azurerm_subnet.subnet-dmz-palo-public.id}"
  network_security_group_id           = "${azurerm_network_security_group.nsg_palo_public.id}"
}

resource "azurerm_subnet_network_security_group_association" "nsg_palo_private" {
  subnet_id                           = "${azurerm_subnet.subnet-dmz-palo-private.id}"
  network_security_group_id           = "${azurerm_network_security_group.nsg_palo_private.id}"
}
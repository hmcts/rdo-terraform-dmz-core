/*
resource "azurerm_subnet" "subnet" {
  count                             = "${length(var.vnet_subnets)}"
  name                              = "${element(split(":", element(var.vnet_subnets, count.index)), 0)}"
  resource_group_name               = "${azurerm_resource_group.rg_dmz.name}"
  virtual_network_name              = "${azurerm_virtual_network.vnet_dmz.name}"
  address_prefix                    = "${element(split(":", element(var.vnet_subnets, count.index)), 1)}"
  network_security_group_id         = "${element(azurerm_network_security_group.nsg.*.id, index(azurerm_network_security_group.nsg.*.name, element(split(":", element(var.nsg_list,count.index)), 0))) }"
  lifecycle { 
     ignore_changes                 = ["route_table_id", "network_security_group_id"]
 }
}

*/

resource "azurerm_subnet" "subnet-mgmt" {
  name                                = "sub-dmz-mgmt"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  virtual_network_name                = "${azurerm_virtual_network.vnet_dmz.name}"
  address_prefix                      = "${var.subnet-mgmt-prefix}"
  network_security_group_id           = "${azurerm_network_security_group.nsg_mgmt.id}"
  lifecycle { 
     ignore_changes                 = ["route_table_id"]
 }

}

resource "azurerm_subnet" "subnet-private" {
  name                                = "sub-dmz-transit-private"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  virtual_network_name                = "${azurerm_virtual_network.vnet_dmz.name}"
  address_prefix                      = "${var.subnet-private-prefix}"
  network_security_group_id           = "${azurerm_network_security_group.nsg_transit_private.id}"
  lifecycle { 
     ignore_changes                 = ["route_table_id"]
 }

}


resource "azurerm_subnet" "subnet-public" {
  name                                = "sub-dmz-transit-public"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  virtual_network_name                = "${azurerm_virtual_network.vnet_dmz.name}"
  address_prefix                      = "${var.subnet-public-prefix}"
  network_security_group_id           = "${azurerm_network_security_group.nsg_transit_public.id}"
  lifecycle { 
     ignore_changes                 = ["route_table_id"]
 }

}


resource "azurerm_subnet_network_security_group_association" "nsg_mgmt" {
  subnet_id                           = "${azurerm_subnet.subnet-mgmt.id}"
  network_security_group_id           = "${azurerm_network_security_group.nsg_mgmt.id}"
}

resource "azurerm_subnet_network_security_group_association" "nsg_transit_private" {
  subnet_id                           = "${azurerm_subnet.subnet-private.id}"
  network_security_group_id           = "${azurerm_network_security_group.nsg_transit_private.id}"
}

resource "azurerm_subnet_network_security_group_association" "nsg_transit_public" {
  subnet_id                           = "${azurerm_subnet.subnet-public.id}"
  network_security_group_id           = "${azurerm_network_security_group.nsg_transit_public.id}"
}
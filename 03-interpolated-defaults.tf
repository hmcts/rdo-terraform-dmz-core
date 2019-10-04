data "azurerm_resource_group" "rg-hub" {
  name                                      = "hub"
}


data "azurerm_virtual_network" "vnet-hub" {
  name                                      = "hub"
  resource_group_name                       = "hub"
}

data "azurerm_subnet" "sub_hub_transit_public" {
  name                                    = "sub-hub-transit-public"
  virtual_network_name                    = "${data.azurerm_virtual_network.vnet-hub.name}"
  resource_group_name                     = "${data.azurerm_resource_group.rg-hub.name}"
}

data "azurerm_network_security_group" "nsg_transit_private" {
  name                                    = "nsg_transit_private"
  resource_group_name                     = "${data.azurerm_resource_group.rg-hub.name}"
}
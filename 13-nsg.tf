resource "azurerm_network_security_group" "nsg_mgmt" {
  name                              = "nsg_mgmt"
  location                          = "${azurerm_resource_group.rg_dmz.location}"
  resource_group_name               = "${azurerm_resource_group.rg_dmz.name}"
}

resource "azurerm_network_security_group" "nsg_loadbalancer" {
  name                              = "nsg_loadbalancer"
  location                          = "${azurerm_resource_group.rg_dmz.location}"
  resource_group_name               = "${azurerm_resource_group.rg_dmz.name}"
}

resource "azurerm_network_security_group" "nsg_palo_public" {
  name                              = "nsg_palo_public"
  location                          = "${azurerm_resource_group.rg_dmz.location}"
  resource_group_name               = "${azurerm_resource_group.rg_dmz.name}"
}

resource "azurerm_network_security_group" "nsg_palo_private" {
  name                              = "nsg_palo_private"
  location                          = "${azurerm_resource_group.rg_dmz.location}"
  resource_group_name               = "${azurerm_resource_group.rg_dmz.name}"
}

resource "azurerm_network_security_rule" "permit_trusted_mgmt" {
  name                                = "permit_trusted_mgmt"
  priority                            = 200
  direction                           = "Inbound"
  access                              = "Allow"
  protocol                            = "tcp"
  source_port_range                   = "*"
  destination_port_range              = "*"
  source_address_prefix               = "213.121.161.124/32"
  destination_address_prefix          = "*"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  network_security_group_name         = "${azurerm_network_security_group.nsg_mgmt.name}"
}


resource "azurerm_network_security_rule" "deny_all" {
  name                                = "deny_all"
  priority                            = 300
  direction                           = "Inbound"
  access                              = "Deny"
  protocol                            = "*"
  source_port_range                   = "*"
  destination_port_range              = "*"
  source_address_prefix               = "*"
  destination_address_prefix          = "*"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  network_security_group_name         = "${azurerm_network_security_group.nsg_mgmt.name}"
}


# Discovers the Azure DevOps IP Address

resource "azurerm_network_security_rule" "azure_devops_mgmt" {
  name                                = "Azure_DataCenter_IPs"
  description		                      = "Azure_DataCenter_IPs"
  priority                            = 201
  direction                           = "Inbound"
  access                              = "Allow"
  protocol                            = "*"
  source_port_range                   = "*"
  destination_port_range              = "*"
  source_address_prefix               = "AzureCloud"
  destination_address_prefix          = "*"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  network_security_group_name         = "${azurerm_network_security_group.nsg_mgmt.name}"
}

resource "azurerm_network_security_rule" "azure_devops_loadbalancer" {
  name                                = "Azure_DataCenter_IPs"
  description		                      = "Azure_DataCenter_IPs"
  priority                            = 200
  direction                           = "Inbound"
  access                              = "Allow"
  protocol                            = "*"
  source_port_range                   = "*"
  destination_port_range              = "*"
  source_address_prefix               = "AzureCloud"
  destination_address_prefix          = "*"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  network_security_group_name         = "${azurerm_network_security_group.nsg_loadbalancer.name}"
}

resource "azurerm_network_security_rule" "AzureLoadBalancer_22" {
  name                                = "AzureLoadBalancer_22"
  description		                      = "AzureLoadBalancer_22"
  priority                            = 215
  direction                           = "Inbound"
  access                              = "Allow"
  protocol                            = "tcp"
  source_port_range                   = "*"
  destination_port_range              = "22"
  source_address_prefix               = "*"
  destination_address_prefix          = "*"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  network_security_group_name         = "${azurerm_network_security_group.nsg_loadbalancer.name}"
}

resource "azurerm_network_security_rule" "AzureLoadBalancer_443" {
  name                                = "AzureLoadBalancer_443"
  description		                      = "AzureLoadBalancer_443"
  priority                            = 216
  direction                           = "Inbound"
  access                              = "Allow"
  protocol                            = "tcp"
  source_port_range                   = "*"
  destination_port_range              = "443"
  source_address_prefix               = "*"
  destination_address_prefix          = "*"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  network_security_group_name         = "${azurerm_network_security_group.nsg_loadbalancer.name}"
}

resource "azurerm_network_security_rule" "AzureLoadBalancer_80" {
  name                                = "AzureLoadBalancer_80"
  description		                      = "AzureLoadBalancer_80"
  priority                            = 217
  direction                           = "Inbound"
  access                              = "Allow"
  protocol                            = "tcp"
  source_port_range                   = "*"
  destination_port_range              = "80"
  source_address_prefix               = "*"
  destination_address_prefix          = "*"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  network_security_group_name         = "${azurerm_network_security_group.nsg_loadbalancer.name}"
}

resource "azurerm_subnet_network_security_group_association" "lb-subnet-nsg" {
  subnet_id                         = "${azurerm_subnet.subnet-dmz-loadbalancer.id}"
  network_security_group_id         = "${azurerm_network_security_group.nsg_loadbalancer.id}"
}

resource "azurerm_subnet_network_security_group_association" "mgmt-subnet-nsg" {
  subnet_id                         = "${azurerm_subnet.subnet-mgmt.id}"
  network_security_group_id         = "${azurerm_network_security_group.nsg_mgmt.id}"
}


/*
resource "azurerm_network_security_rule" "dmz_vnet_cidr" {
  name                                = "dmz_vnet_cidr"
  description		                      = "dmz_vnet_cidr"
  priority                            = 199
  direction                           = "Inbound"
  access                              = "Allow"
  protocol                            = "*"
  source_port_range                   = "*"
  destination_port_range              = "*"
  source_address_prefix               = "VirtualNetwork"  #"${var.vnet_cidr}"
  destination_address_prefix          = "*"
  resource_group_name                 = "${data.azurerm_resource_group.rg-hub.name}"
  network_security_group_name         = "${data.azurerm_network_security_group.nsg_transit_private.name}"
}

*/
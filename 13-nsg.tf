resource "azurerm_network_security_group" "nsg" {
  count                             = "${length(var.nsg_list)}"
  name                              = "${element(split(":", element(var.nsg_list,count.index)), 0)}"
  location                          = "${azurerm_resource_group.rg_dmz.location}"
  resource_group_name               = "${azurerm_resource_group.rg_dmz.name}"
}

resource "azurerm_network_security_rule" "nsg_rule" {
  count                             = "${length(var.nsg_rules)}"
  name                              = "${element(split(":", element(var.nsg_rules, count.index)), 1)}"
  priority                          = "${element(split(":", element(var.nsg_rules,count.index)), 2)}"
  direction                         = "${element(split(":", element(var.nsg_rules,count.index)), 3)}"
  access                            = "${element(split(":", element(var.nsg_rules,count.index)), 4)}"
  protocol                          = "${element(split(":", element(var.nsg_rules,count.index)), 5)}"
  source_port_range                 = "${element(split(":", element(var.nsg_rules,count.index)), 6)}"
  destination_port_range            = "${element(split(":", element(var.nsg_rules,count.index)), 7)}"
  source_address_prefix             = "${element(split(":", element(var.nsg_rules,count.index)), 8)}"
  destination_address_prefix        = "${element(split(":", element(var.nsg_rules,count.index)), 9)}"
  resource_group_name               = "${azurerm_resource_group.rg_dmz.name}"
  network_security_group_name       = "${element(azurerm_network_security_group.nsg.*.name, index(azurerm_network_security_group.nsg.*.name, element(split(":", element(var.nsg_rules,count.index)), 0)))}"

}

resource "azurerm_subnet_network_security_group_association" "proxy-subnet-nsg" {
  subnet_id                         = "${element(azurerm_subnet.subnet.*.id, index(azurerm_subnet.subnet.*.name, var.proxy_subnet_vip))}"
  network_security_group_id         = "${element(azurerm_network_security_group.nsg.*.id, index(azurerm_network_security_group.nsg.*.name, "nsg_proxy"))}"
}

resource "azurerm_subnet_network_security_group_association" "lb-subnet-nsg" {
  subnet_id                         = "${element(azurerm_subnet.subnet.*.id, index(azurerm_subnet.subnet.*.name, var.loadbalancer_subnet_vip))}"
  network_security_group_id         = "${element(azurerm_network_security_group.nsg.*.id, index(azurerm_network_security_group.nsg.*.name, "nsg_loadbalancer"))}"
}

resource "azurerm_subnet_network_security_group_association" "mgmt-subnet-nsg" {
  subnet_id                         = "${element(azurerm_subnet.subnet.*.id, index(azurerm_subnet.subnet.*.name, var.loadbalancer_subnet_management))}"
  network_security_group_id         = "${element(azurerm_network_security_group.nsg.*.id, index(azurerm_network_security_group.nsg.*.name, "nsg_mgmt"))}"
}


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
  network_security_group_name         = "${element(azurerm_network_security_group.nsg.*.name, 0)}"
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
  network_security_group_name         = "${element(azurerm_network_security_group.nsg.*.name, 1)}"
}



resource "azurerm_network_security_rule" "azure_devops_proxy" {
  name                                = "Azure_DataCenter_IPs"
  description		                      = "Azure_DataCenter_IPs"
  priority                            = 202
  direction                           = "Inbound"
  access                              = "Allow"
  protocol                            = "*"
  source_port_range                   = "*"
  destination_port_range              = "*"
  source_address_prefix               = "AzureCloud"
  destination_address_prefix          = "*"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  network_security_group_name         = "${element(azurerm_network_security_group.nsg.*.name, 2)}"
}

resource "azurerm_network_security_rule" "azure_devops_sftp" {
  name                                = "Azure_DataCenter_IPs"
  description		                      = "Azure_DataCenter_IPs"
  priority                            = 203
  direction                           = "Inbound"
  access                              = "Allow"
  protocol                            = "*"
  source_port_range                   = "*"
  destination_port_range              = "*"
  source_address_prefix               = "AzureCloud"
  destination_address_prefix          = "*"
  resource_group_name                 = "${azurerm_resource_group.rg_dmz.name}"
  network_security_group_name         = "${element(azurerm_network_security_group.nsg.*.name, 3)}"
}

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

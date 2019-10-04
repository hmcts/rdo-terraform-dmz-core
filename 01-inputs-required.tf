variable "subscription_id" { }

variable "environment" {}
variable "rg_name" { }
variable "vnet_name" { }
variable "vnet_cidr" { }

variable "subnet-mgmt-prefix" { }

variable "subnet-dmz-proxy-prefix" { }

variable "subnet-dmz-loadbalancer-prefix" { }
variable "subnet-dmz-palo-public-prefix" { }
variable "subnet-dmz-palo-private-prefix" { }

variable "loadbalancer_subnet_management" { }
variable "loadbalancer_subnet_vip" { }

variable "proxy_vm_name" {}
variable "proxy_admin_username" { }
variable "proxy_admin_password" { }
variable "proxy_subnet_vip" { }
variable "arm_client_id" { }
variable "arm_client_secret" { }
variable "arm_tenant_id" { }

variable "azcontainer_password" { }


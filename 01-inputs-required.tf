variable "subscription_id" { }
variable "rg_name" { }
variable "vnet_name" { }
variable "vnet_cidr" { }

variable "vnet_subnets" {
  type                                = "list"
}
variable "nsg_list" {
  type                                = "list"
}
variable "nsg_rules" {
  type                                = "list"
}
variable "loadbalancer_subnet_management" { }
variable "loadbalancer_subnet_vip" { }
variable "environment" { }
variable "proxy_vm_name" {}
variable "proxy_admin_username" { }
variable "proxy_admin_password" { }
variable "proxy_admin_ssh_public_key" { }
variable "proxy_subnet_vip" { }
variable "arm_client_id" { }
variable "arm_client_secret" { }
variable "arm_tenant_id" { }

variable "subnet-public-prefix" {
  description                       = "Public IP Range Prefix"
  
}

variable "subnet-private-prefix" {
  description                       = "Private IP Range Prefix"
  
}

variable "subnet-mgmt-prefix" {
  description                       = "Management IP Range Prefix"
  
}
variable "rg_location" {
  description                       = "Location to build all the resources in"
  default                           = "UK South"
}

variable "tags" {
  description                             = "The tags to associate with your resources."
  type                                    = "map"
  default                                 = {
      Team                                = "Reform-DevOps"
  }
}

variable "azuredevops_ips" {

    type = "list"
    default = [ "13.107.6.0/24", "13.107.9.0/24", "13.107.42.0/24", "13.107.43.0/24"]
}



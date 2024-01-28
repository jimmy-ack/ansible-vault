### AZURE CONNECTIONS SETTINGS ###

# Add variables for Azure : 
# client_id, client_secret, tenant_id, subscription_id

variable "resource_group_name" {
  default = "rg-shared-sandbox"
}

### PROJECT VARIABLES ###

variable "vm_count" {
  default = 3
}

variable "tags" {
  default = {
    env : "sandbox",
    owner : "jic"
  }
}

### VNET VARIABLES ###


### VIRTUAL MACHINES VARIABLES ###

variable "location" {
  default = "West Europe"
}

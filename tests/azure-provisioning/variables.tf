### AZURE CONNECTIONS SETTINGS ###

variable "client_secret" {
  default = "2D28Q~4QpQxTp7WG6iHTJKGATqZDwnj1u6LK6aTT"
}

variable "client_id" {
  default = "a196a745-ab69-4043-92bc-9cc4dcc9c2f8"
}

variable "tenant_id" {
  default = "f9056c40-d204-4118-b01d-bb624708154c"
}

variable "subscription_id" {
  default = "9ca13539-bff8-42c2-bad9-106ee8827ff4"
}

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

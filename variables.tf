variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vnet_name" {
  description = "Name for virtual network"
  type = string
}

variable "vnet_name-02" {
  description = "Name for virtual network-02"
  type = string
}

variable "address_space" {
  description = "Virtual Network defined address space"
  type = list(string)
}

variable "address_space-02" {
  description = "Virtual Network-02 defined address space"
  type = list(string)
}


variable "appsubnet" {
  description = "Name for app subnet"
  type = string
}

variable "appsubnet02" {
  description = "Name for app subnet"
  type = string
}

variable "address_space_appsubnet" {
  description = "Appsubnet defined address space"
  type = list(string)
}

variable "address_space_appsubnet02" {
  description = "Appsubnet defined address space"
  type = list(string)
}


variable "websubnet" {
  description = "Name for web subnet"
  type = string
}

variable "websubnet02" {
  description = "Name for web subnet"
  type = string
}

variable "address_space_websubnet" {
  description = "Websubnet defined address space"
  type = list(string)
}

variable "address_space_websubnet02" {
  description = "Websubnet defined address space"
  type = list(string)
}

variable "dbsubnet" {
  description = "Name for db subnet"
  type = string
}

variable "dbsubnet02" {
  description = "Name for db subnet"
  type = string
}

variable "bastionsubnet" {
  description = "Name for bastion subnet"
  type = string
}

variable "address_space_bastionsubnet" {
  description = "dbsubnet defined address space"
  type = list(string)
}

variable "address_space_dbsubnet" {
  description = "dbsubnet defined address space"
  type = list(string)
}

variable "address_space_dbsubnet02" {
  description = "dbsubnet defined address space"
  type = list(string)
}

variable "address_space_gatewaysubnet" {
  description = "gatewaysubnet defined address space"
  type = list(string)
}


variable "dns_servers" {
  description = "local defined dns servers"
  type = list(string)
}


variable "admin_password" {
  description = "local admin password"
  type = string
}

variable "vm_to_create" {
  description = "This is meant to be used with the for_each iteration, used to determine the number of vm, nic and storage account to create"
  type = map(string)
}

variable "ssh_pubkey_path"{
  description = "The absolute path for where the public key resides on your local system for terraform to use with the file syntax to pass the public key to azure"
  type = string
}
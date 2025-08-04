variable "gateway_name" {
  type = string
}

variable "gateway_ngs_name" {
  type = string
}

variable "gateway_ngs_allow_apim_public_ip" {
  type = string
}

variable "gateway_sku_name" {
  type = string
}
variable "gateway_sku_tier" {
  type = string
}

variable "gateway_min_capacity" {
  type = number
}

variable "gateway_max_capacity" {
  type = number
}

variable "gateway_ip_configuration" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "subnet_address_prefixes" {
  type = list(string)
}

variable "subnet_virtual_network_name" {
  type = string
}

variable "public_ip_name" {
  type = string
}

variable "public_ip_allocation_method" {
  type = string
}

variable "public_ip_sku" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

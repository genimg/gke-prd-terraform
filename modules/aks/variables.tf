variable "cluster_name" {
  type = string
}

variable "registry_name" {
  type = string
}

variable "registry_resource_group_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "local_account_disabled" {
  type = bool
}

variable "private_cluster_enabled" {
  type = bool
}

variable "resource_group_location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "default_node_name" {
  type = string
}

variable "default_node_vm_size" {
  type = string
}

variable "default_node_subnet_id" {
  type = string
}

variable "default_node_zones" {
  type = list(string)
}

variable "default_node_type" {
  type = string
}

variable "enable_auto_scaling" {
  type = bool
}

variable "default_node_min_count" {
  type = number
}

variable "default_node_max_count" {
  type = number
}

variable "default_node_max_pods" {
  type = number
}

variable "default_node_os_disk_size_gb" {
  type = number
}

variable "network_profile_plugin" {
  type = string
}

variable "network_profile_policy" {
  type = string
}

variable "network_profile_load_balancer_sku" {
  type = string
}

variable "identity_type" {
  type = string
}

variable "azure_policy_enabled" {
  type = bool
}

variable "tags" {
  type = map(string)
}
# hub
variable "resource_group_hub_name" {}
variable "resource_group_hub_location" {}
variable "virtual_network_hub_name" {}
variable "virtual_network_hub_address" {}
variable "peering_hub_to_spoke_1_name" {}
variable "peering_hub_to_spoke_1_traffic" {}
variable "subnet_hub_bastion_name" {}
variable "subnet_hub_bastion_address" {}

# spoke
variable "resource_group_spoke_1_name" {}
variable "resource_group_spoke_1_location" {}
variable "virtual_network_spoke_1_name" {}
variable "virtual_network_spoke_1_address" {}
variable "peering_spoke_1_aks_hub_name" {}
variable "peering_spoke_1_aks_hub_traffic" {}
variable "subnet_spoke_1_aks_name" {}
variable "subnet_spoke_1_aks_address" {}
variable "route_table_spoke_1_aks_name" {}

# bastion
variable "bastion_main_public_ip_name" {}
variable "bastion_main_network_interface_name" {}
variable "bastion_main_virtual_machine_name" {}
variable "bastion_main_virtual_machine_size" {}
variable "bastion_main_ngs_name" {}

# gateway
variable "gateway_default_name" {}
variable "gateway_default_sku_name" {}
variable "gateway_default_sku_tier" {}
variable "gateway_default_min_capacity" {}
variable "gateway_default_max_capacity" {}
variable "gateway_default_ip_configuration" {}
variable "gateway_default_subnet_name" {}
variable "gateway_default_nsg_name" {}
variable "gateway_default_subnet_address_prefixes" {}
variable "gateway_default_public_ip_name" {}
variable "gateway_default_public_ip_allocation_method" {}
variable "gateway_default_public_ip_sku" {}

#apim
variable "apim_default_name" {}
variable "apim_default_sku_name" {}
variable "apim_default_publisher_name" {}
variable "apim_default_publisher_email" {}

#aks
variable "aks_main_cluster_name" {}
variable "aks_main_registry_name" {}
variable "aks_main_registry_resource_group_name" {}
variable "aks_main_dns_prefix" {}
variable "aks_main_local_account_disabled" {}
variable "aks_main_private_cluster_enabled" {}
variable "aks_main_default_node_name" {}
variable "aks_main_default_node_vm_size" {}
variable "aks_main_default_node_zones" {}
variable "aks_main_default_node_type" {}
variable "aks_main_enable_auto_scaling" {}
variable "aks_main_default_node_min_count" {}
variable "aks_main_default_node_max_count" {}
variable "aks_main_default_node_max_pods" {}
variable "aks_main_default_node_os_disk_size_gb" {}
variable "aks_main_network_profile_plugin" {}
variable "aks_main_network_profile_policy" {}
variable "aks_main_network_profile_load_balancer_sku" {}
variable "aks_main_identity_type" {}
variable "aks_main_azure_policy_enabled" {}
variable "aks_main_tags" {}

# GCP / GKE
variable "gcp_project_id" {}

variable "gke_main_cluster_name" {}
variable "gke_main_location" {}
variable "gke_main_network" {}
variable "gke_main_subnetwork" {}
variable "gke_main_node_pools" {
  type = list(object({
    name           = string
    machine_type   = string
    min_count      = number
    max_count      = number
    disk_size_gb   = number
    labels         = map(string)
    taints         = list(object({
      key    = string
      value  = string
      effect = string
    }))
  }))
}

variable "gke_main_tags" {
  type = map(string)
}

# Bastion GCP
variable "bastion_gcp_instance_name" {}
variable "bastion_gcp_zone" {}
variable "bastion_gcp_machine_type" {}
variable "bastion_gcp_network" {}
variable "bastion_gcp_subnetwork" {}
variable "bastion_gcp_disk_size_gb" {
  default = 20
}
variable "bastion_gcp_tags" {
  type    = list(string)
  default = ["bastion"]
}
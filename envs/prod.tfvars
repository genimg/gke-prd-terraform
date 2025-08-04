# hub
resource_group_hub_name     = "p-vuelo-hub-rg-eus2-mm4o"
resource_group_hub_location = "eastus2"
virtual_network_hub_name = "p-vuelo-vnet-eus2-rt99"
virtual_network_hub_address = ["23.0.0.0/16"]
peering_hub_to_spoke_1_name = "p-vuelo-peer-eus2-4d1a"
peering_hub_to_spoke_1_traffic = true
subnet_hub_bastion_name =  "p-vuelo-snet-eus2-2a3c"
subnet_hub_bastion_address = ["23.0.5.0/27"]

# spoke 1
resource_group_spoke_1_name     = "p-vuelo-spoke-rg-eus2-mw4o"
resource_group_spoke_1_location = "eastus2"
virtual_network_spoke_1_name = "p-vuelo-vnet-eus2-2t19"
virtual_network_spoke_1_address = ["23.1.0.0/16"]
peering_spoke_1_aks_hub_name = "p-vuelo-peer-eus2-1ce3"
peering_spoke_1_aks_hub_traffic = true
subnet_spoke_1_aks_name    = "p-vuelo-snet-eus2-ab56"
subnet_spoke_1_aks_address = ["23.1.0.0/22"]
route_table_spoke_1_aks_name = "p-vuelo-rt-eus2-e8ju"

# bastion
bastion_main_public_ip_name = "p-vuelo-pip-eus2-fg36"
bastion_main_network_interface_name = "p-vuelo-nip-eus2-ed27"
bastion_main_virtual_machine_name = "p-vuelo-vm-eus2-5tt6"
bastion_main_virtual_machine_size = "Standard_B1s"
bastion_main_ngs_name = "p-vuelo-nsg-eus2-55t8"

# agic
gateway_default_name = "p-vuelo-agw-eus2-a6b8"
gateway_default_sku_name = "Standard_v2"
gateway_default_sku_tier = "Standard_v2"
gateway_default_min_capacity = 1
gateway_default_max_capacity = 2
gateway_default_nsg_name = "p-vuelo-nsg-apim-eus2-a34r"
gateway_default_ip_configuration = "p-vuelo-ipconf-eus2-ft12"
gateway_default_subnet_name = "p-vuelo-snet-eus2-am34"
gateway_default_subnet_address_prefixes = ["23.1.4.0/24"]
gateway_default_public_ip_name = "p-vuelo-pip-eus2-t45r"
gateway_default_public_ip_allocation_method = "Static"
gateway_default_public_ip_sku = "Standard"

#apim
apim_default_name = "p-vuelo-apim-eus2-34y6"
apim_default_sku_name ="Basic_1"
apim_default_publisher_name = "Expertia"
apim_default_publisher_email = "company@terraform.io"

# aks
aks_main_cluster_name = "p-vuelo-aks-eus2-z3f1"
aks_main_registry_name = "psharecreus2a935"
aks_main_registry_resource_group_name = "p-share-rg-eus2-c367"
aks_main_dns_prefix = "mvexpertia"
aks_main_local_account_disabled=true
aks_main_private_cluster_enabled = true
aks_main_default_node_name = "cvueloeus2"
aks_main_default_node_vm_size ="Standard_D8s_v3"
aks_main_default_node_zones = ["1", "3"]
aks_main_default_node_type = "VirtualMachineScaleSets"
aks_main_enable_auto_scaling = true
aks_main_default_node_min_count = 1
aks_main_default_node_max_count = 3
aks_main_default_node_max_pods = 50
aks_main_default_node_os_disk_size_gb = 100
aks_main_network_profile_plugin = "azure"
aks_main_network_profile_policy = "azure"
aks_main_network_profile_load_balancer_sku ="standard"
aks_main_identity_type ="SystemAssigned"
aks_main_azure_policy_enabled = true
aks_main_tags =  {Environment = "Testing"}
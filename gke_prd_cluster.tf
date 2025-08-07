resource "google_container_cluster" "sap_prd" {
  provider = google.spoke

  name     = "integration-sap-prd-cluster"
  location = "southamerica-west1"

  release_channel { channel = "STABLE" }
  networking_mode = "VPC_NATIVE"

  network    = data.google_compute_subnetwork.sap_prd_subnet.network
  subnetwork = data.google_compute_subnetwork.sap_prd_subnet.self_link

  ip_allocation_policy {
    cluster_secondary_range_name  = "alias-pods-prd"
    services_secondary_range_name = "alias-services-prd"
  }

  private_cluster_config {
    enable_private_nodes   = true
    enable_private_endpoint = false
    master_global_access_config { enabled = false }
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.253.0.0/16"   # toda tu VPC compartida
      display_name = "vpc-interna"
    }
  }

  gateway_api_config { channel = "CHANNEL_STANDARD" }

  remove_default_node_pool = true
  initial_node_count = 1
  lifecycle {
    ignore_changes = [maintenance_policy]
  }
}

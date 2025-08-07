resource "google_container_node_pool" "sap_prd_np" {
  provider = google.spoke

  name       = "default-pool"
  cluster    = google_container_cluster.sap_prd.name
  location   = google_container_cluster.sap_prd.location

  node_config {
    machine_type    = "n2-standard-4"
    service_account = var.nodes_sa_email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }
}

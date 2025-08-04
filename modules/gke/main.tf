resource "google_container_cluster" "this" {
  name                     = var.cluster_name
  location                 = var.location
  project                  = var.project_id

  network                  = var.network
  subnetwork               = var.subnetwork

  remove_default_node_pool = true
  initial_node_count       = 1 # Dummy value, required when removing default node pool

  # Recommended security features
  enable_shielded_nodes = true
  release_channel {
    channel = "REGULAR"
  }

  # Tags / labels
  resource_labels = var.tags
}

# Create one node pool resource per element in the variable list
resource "google_container_node_pool" "pools" {
  for_each = { for np in var.node_pools : np.name => np }

  name       = each.value.name
  project    = var.project_id
  cluster    = google_container_cluster.this.name
  location   = var.location

  # Autoscaling configuration
  autoscaling {
    min_node_count = each.value.min_count
    max_node_count = each.value.max_count
  }

  node_config {
    machine_type   = each.value.machine_type
    disk_size_gb   = each.value.disk_size_gb
    labels         = each.value.labels

    dynamic "taint" {
      for_each = each.value.taints == null ? [] : each.value.taints
      content {
        key    = taint.key
        value  = taint.value
        effect = taint.effect
      }
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

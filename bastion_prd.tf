# Bastion host resources for PRD

###################################################################################################
# 1. Service Account that the bastion VM will run as                                              #
###################################################################################################
resource "google_service_account" "bastion_sa" {
  provider     = google.spoke
  account_id   = var.bastion_sa_id
  display_name = "Bastion host SA"
}

# Minimum permissions so that the VM can write logs and metrics
resource "google_project_iam_member" "bastion_sa_logging" {
  provider = google.spoke
  project  = var.spoke_project_id
  role     = "roles/logging.logWriter"
  member   = "serviceAccount:${google_service_account.bastion_sa.email}"
}

resource "google_project_iam_member" "bastion_sa_monitoring" {
  provider = google.spoke
  project  = var.spoke_project_id
  role     = "roles/monitoring.metricWriter"
  member   = "serviceAccount:${google_service_account.bastion_sa.email}"
}

###################################################################################################
# 2. Bastion VM instance                                                                          #
###################################################################################################
resource "google_compute_instance" "bastion" {
  provider = google.spoke

  name         = "bastion-prd"
  machine_type = var.bastion_machine_type
  zone         = var.bastion_zone

  tags = ["bastion"]

  # Use the latest Ubuntu LTS image
  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
      size  = 10
      type  = "pd-balanced"
    }
  }

  # Attach to the shared VPC subnetwork; no public IP (access via VPN/IAP)
  network_interface {
    subnetwork         = data.google_compute_subnetwork.sap_prd_subnet.self_link
    subnetwork_project = var.host_project_id
    # No external IP -> omit access_config block
  }

  service_account {
    email  = google_service_account.bastion_sa.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata = {
    enable-osconfig = "TRUE"
  }
}

###################################################################################################
# 3. Firewall rule to allow SSH from VPN ranges to the bastion                                    #
###################################################################################################
resource "google_compute_firewall" "bastion_ssh" {
  provider = google

  name    = "allow-bastion-ssh-prd"
  network = data.google_compute_subnetwork.sap_prd_subnet.network

  # TODO: Adjust source ranges to the actual on-prem / VPN CIDR blocks
  source_ranges = [
    "10.253.0.0/16" # Shared VPC range (replace or append as required)
  ]

  target_tags = ["bastion"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
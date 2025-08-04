resource "google_compute_address" "static" {
  name   = "${var.instance_name}-ip"
  region = substr(var.zone, 0, length(var.zone)-2) # derive region from zone
}

resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh-bastion"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["bastion"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "bastion" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    initialize_params {
      image  = "ubuntu-os-cloud/ubuntu-2204-lts"
      size   = var.disk_size_gb
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
  }
}

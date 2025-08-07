resource "google_sql_database_instance" "sap_postgres_prd" {
  provider         = google.spoke
  name             = var.db_instance_name
  region           = "southamerica-west1"
  database_version = "POSTGRES_16"

  settings {
    tier              = "db-custom-4-16384"   // 4 vCPU | 16 GB
    availability_type = "REGIONAL"            // HA zonal
    disk_type         = "PD_SSD"
    disk_size         = 100                    // GB
    activation_policy = "ALWAYS"

    ip_configuration {
      ipv4_enabled    = false
      private_network = "projects/${var.host_project_id}/global/networks/vpc-irmabo-integraciones-sap"
    }
  }

  deletion_protection = true
  #depends_on          = [google_service_networking_connection.cloudsql_connection]
}

resource "google_sql_user" "root" {
  provider = google.spoke
  instance = google_sql_database_instance.sap_postgres_prd.name
  name     = "postgres"
  password = var.db_password
}
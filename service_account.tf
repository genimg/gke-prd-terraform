data "google_project" "spoke" {
  project_id = var.spoke_project_id
}

resource "google_project_iam_member" "gke_sa_on_host" {
  provider = google           # HOST provider
  project  = var.host_project_id
  role     = "roles/container.hostServiceAgentUser"
  member   = "serviceAccount:service-${data.google_project.spoke.number}@container-engine-robot.iam.gserviceaccount.com"
}


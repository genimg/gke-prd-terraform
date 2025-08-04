output "cluster_name" {
  value = google_container_cluster.sap_prd.name
}
output "cluster_region" {
  value = google_container_cluster.sap_prd.location
}

resource "google_sql_database" "schemas" {
  provider = google.spoke
  for_each = toset(var.db_names)

  instance  = google_sql_database_instance.sap_postgres_prd.name
  name      = each.key
  charset   = "UTF8"
  collation = "en_US.UTF8"
}
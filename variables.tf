variable "host_project_id"  { type = string } # p.ej. "d-irmabo-integraciones-sap"
variable "spoke_project_id" { type = string } # p.ej. "d-irmabo-integraciones-sap"
variable "nodes_sa_email"   { type = string } # SA p/ nodos (formato user@project.iam.gserviceaccount.com)

variable "db_instance_name"   { 
    type = string  
    default = "integracion-db-prd" 
}
variable "db_password"        { 
    type = string  
    sensitive = true 
}
variable "db_names" {
  type    = list(string)
  default = [
    "airflow",
    "camunda_venta_desagregada_hpsa",
    "camunda_venta_desagregada_tpsa",
    "ec_bpm_backoffice",
    "ec_camunda_supplier",
    "ec_camunda_supplier_parameter",
    "fp_bpm_backoffice",
    "integracion",
    "keycloak",
    "neptuno"
  ]
}

variable "bastion_machine_type" {
  type        = string
  description = "Tipo de máquina del bastion"
  default     = "e2-medium"          # 2 vCPU / 4 GB RAM
}

variable "bastion_zone" {
  type        = string
  description = "Zona del bastion"
  default     = "southamerica-west1-a"
}

variable "bastion_sa_id" {
  type        = string
  description = "ID de la service account del bastion (sin @ ni dominio)"
  default     = "bastion-prd-sa"
}

variable "iap_ssh_members" {
  type        = list(string)
  description = "Usuarios / grupos autorizados a usar IAP-SSH contra el bastion"
  default     = ["user:ormenovargasc@gmail.com"]   # ⇦ ajusta o añade más
}
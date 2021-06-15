
variable "postges-settings" {
  type = map(any)
}

variable "postgres-variables" {
  type = map(any)

}

variable "backup_location" {
  description = "set backup location"
  default     = null
}

variable "random_instance_name" {
  type        = bool
  description = "Sets random suffix at the end of the Cloud SQL resource name"
  default     = true
}

variable "component_name" {
  description = "componenet name for ansible"
  default = "postgresDB"
}


variable "postgres_database_labels" {}


locals {
  postgres_database_labels = merge("${var.postgres_database_labels}", { role = "${var.component_name}" }, { deployment_id = "${var.deployment_id}" })
 }


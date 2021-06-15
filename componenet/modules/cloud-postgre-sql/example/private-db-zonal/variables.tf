variable "project" {
  description = "The project to deploy to, if not set the default provider project is used."
  type        = string
}

variable "project_id" {
  type        = string
  description = "The project to run tests against"
}
variable "region" {
  description = "Region for cloud resources"
  type        = string
}
variable "network_name" {
  description = "The name of the VPC to be created"
  type        = string
}
variable "postges-settings" {
  type = map(any)
}

variable "pg_ha_name" {
  description = "The name of the SQL Database instance"
}
variable "database_zone" {
  description = "The zone in which db installed"
}

variable "db_name" {
  description = "The db user"
}

variable "db_user" {
  description = "The db user"
}
variable "db_password" {
  description = "The zone in which db installed"
}

variable "db_user2" {
  description = "The db user, yet another"
}
variable "db_password2" {
  description = "optional password 2"
}

variable "require_ssl" {
  description = " Should PGSQL need SSL connection"
  // This is set to false only for poc
  default = false
}


variable "pg_ha_external_ip_range" {
  description = "authorised network"
}

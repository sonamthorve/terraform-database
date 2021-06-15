/**
 * Postgres high availability
 * Rename  the file to .tf (remove .disabled extension). This is expensive
*/
//https://github.com/terraform-google-modules/terraform-google-sql-db/blob/master/examples/postgresql-ha/variables.tf
locals {
  read_replica_ip_configuration = {
    ipv4_enabled = true
    require_ssl  = var.postges-settings["require_ssl"]
    //Private db is not enabled
    private_network = null
    authorized_networks = [
      {
        name  = "${var.project_id}-cidr"
        value = var.pg_ha_external_ip_range
      },
    ]
  }
}
module "postgresql-db-ha" {
  source = "../../../cloud-postgre-sql"

  //Instance details
  name                 = var.pg_ha_name
  random_instance_name = true
  database_version     = var.postges-settings["database_version"]
  create_timeout       = var.postges-settings["create_timeout"]
  update_timeout       = var.postges-settings["update_timeout"]
  delete_timeout       = var.postges-settings["delete_timeout"]



  project_id = var.project_id
  region     = var.region

  // Master config
  tier                            = var.postges-settings["tier"]
  zone                            = var.database_zone
  availability_type               = var.postges-settings["availability_type"]
  maintenance_window_day          = 7
  maintenance_window_hour         = 12
  maintenance_window_update_track = "stable"
  // Add any more detasbe settings
  database_flags = [{ name = "autovacuum", value = "off" }]

  user_labels = {
    name = "authentic"
  }

  ip_configuration = {
    ipv4_enabled    = true
    require_ssl     = var.require_ssl
    private_network = null
    authorized_networks = [
      {
        name  = "${var.project_id}-cidr"
        value = var.pg_ha_external_ip_range
      },
    ]
  }

  backup_configuration = {
    enabled                        = false
    start_time                     = "20:55"
    location                       = null
    point_in_time_recovery_enabled = false
  }
  // Below add the default  db
  db_name      = var.pg_ha_name
  db_charset   = "UTF8"
  db_collation = "en_US.UTF8"
  // User details
  user_name     = var.db_user
  user_password = var.db_password

  additional_users = [
    {
      name     = var.db_user2
      password = var.db_password2
      host     = "localhost"
    },
  ]
  //Additional database

  additional_databases = [
    {
      name      = "${var.pg_ha_name}-additional"
      charset   = "UTF8"
      collation = "en_US.UTF8"
    },
  ]

  // Read replica configurations
  read_replica_name_suffix = var.postges-settings.read_replica_name_suffix
  read_replicas = [
    {
      name             = "0"
      zone             = "us-central1-a"
      tier             = var.postges-settings["tier"]
      ip_configuration = local.read_replica_ip_configuration
      database_flags   = [{ name = "autovacuum", value = "off" }]
      disk_autoresize  = null
      disk_size        = null
      disk_type        = var.postges-settings["disk_type"]
      user_labels      = { name = "authentic" }
    },
  ]
}

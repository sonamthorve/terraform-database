//Postgres high availability with backup & replica configurations


locals {
  read_replica_ip_configuration = {
    ipv4_enabled    = var.postgres-variables["read_replica_ip_configuration_ipv4"]
    require_ssl     = var.postges-settings["require_ssl"]
    private_network = data.google_compute_network.private_network.id
    authorized_networks = [
      {
        name  = "${var.project}-cidr"
        value = var.postgres-variables["pg_ha_external_ip_range"]
      },
    ]
  }
}



module "postgresql-db" {
  source = "../../sreg-modules/cloud-postgre-sql"


  user_labels          = local.postgres_database_labels
  name                 = var.postgres-variables["pg_ha_name"]
  random_instance_name = var.random_instance_name
  database_version     = var.postges-settings["database_version"]
  create_timeout       = var.postges-settings["create_timeout"]
  update_timeout       = var.postges-settings["update_timeout"]

  delete_timeout    = var.postges-settings["delete_timeout"]
  availability_type = var.postges-settings["availability_type"]

  maintenance_window_day          = var.postgres-variables["maintenance_window_day"]
  maintenance_window_hour         = var.postgres-variables["maintenance_window_hour"]
  maintenance_window_update_track = var.postgres-variables["maintenance_window_update_track"]

  project_id    = var.project
  zone          = var.postgres-variables["database_zone"]
  region        = var.region
  tier          = var.postges-settings["tier"]
  disk_size     = var.postges-settings["disk_size"]
  disk_autoresize  = var.postges-settings["disk_autoresize"]
  disk_type        = var.postges-settings["disk_type"]
  user_name     = var.postgres-variables["db_user"]
  user_password = var.postgres-variables["db_password"]



  ip_configuration = {
    ipv4_enabled    = var.postgres-variables["ip_configuration_ipv4_enabled"]
    private_network = data.google_compute_network.private_network.id
    require_ssl     = var.postgres-variables["require_ssl"]
    authorized_networks = [
      {
        name  = var.postgres-variables["ip_configuration_name"]
        value = var.postgres-variables["ip_configuration_value"]
      },
    ]
  }


  backup_configuration = {
    enabled                        = var.postgres-variables["backup_enabled"]
    start_time                     = var.postgres-variables["backup_start_time"]
    location                       = var.backup_location
    point_in_time_recovery_enabled = var.postgres-variables["backup_point_in_time_recovery"]
  }

  // Below add the default  db
  db_name      = var.postgres-variables["db_name"]
  db_charset   = var.postgres-variables["db_charset"]
  db_collation = var.postgres-variables["db_collation"]


  database_flags = [{ name = var.postgres-variables["database_flags_name"], value = var.postgres-variables["database_flags_value"] },
                    { name = var.postgres-variables["database_flags_name1"], value = var.postgres-variables["database_flags_value1"] },
				            { name = var.postgres-variables["database_flags_name2"], value = var.postgres-variables["database_flags_value2"] } 
				           ]


  //Additional database

  additional_databases = [
    {
      name      = "${var.postgres-variables["db_name"]}-additional"
      charset   = var.postgres-variables["db_charset"]
      collation = var.postgres-variables["db_collation"]
    },
  ]



  // Read replica configuration

  read_replica_name_suffix = var.postges-settings.read_replica_name_suffix
  read_replicas = [
    {

      name             = var.postges-settings["name"]
      zone             = "${var.region}-${var.postges-settings["replica_zone"]}"
      tier             = var.postges-settings["tier"]
      ip_configuration = local.read_replica_ip_configuration
      database_flags = [{ name = var.postgres-variables["database_flags_name"], value = var.postgres-variables["database_flags_value"] },
                        { name = var.postgres-variables["database_flags_name1"], value = var.postgres-variables["database_flags_value1"] },
				                { name = var.postgres-variables["database_flags_name2"], value = var.postgres-variables["database_flags_value2"] } 
				               ]
      disk_autoresize  = var.postges-settings["disk_autoresize"]
      disk_size        = var.postges-settings["disk_size"]
      disk_type        = var.postges-settings["disk_type"]
      user_labels      = local.postgres_replica_labels
    },
  ]

}



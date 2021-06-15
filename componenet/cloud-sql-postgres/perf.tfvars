postgres-variables = {
  db_name                 = "pgsql-db"
  database_zone           = "c"
  pg_ha_name              = "pgdb-inst"
  db_user                 = "user1"
  db_password             = "user1"
 
  pg_ha_external_ip_range = "0.0.0.0/0"
  #####
  require_ssl                        = "false"
  maintenance_window_day             = "7"
  maintenance_window_hour            = "12"
  maintenance_window_update_track    = "stable"
  backup_enabled                     = "true"
  backup_point_in_time_recovery      = "false"
  backup_start_time                  = "20:55"
  database_flags_name                = "autovacuum"
  database_flags_value               = "off"
  database_flags_name1               = "autovacuum_max_workers"
  database_flags_value1              = "260000"
  database_flags_name2               = "max_connections"
  database_flags_value2              = "400"
  ip_configuration_ipv4_enabled      = "false"
  ip_configuration_name              = "cloudsql"
  ip_configuration_value             = "0.0.0.0/0"
  read_replica_ip_configuration_ipv4 = "false"
  host                               = "localhost"
  db_charset                         = "UTF8"
  db_collation                       = "en_US.UTF8"
}

postgres_database_labels = {
  product = "qa"
  role    = "postgres"
  name    = "pgdb"
}

postgres_replica_labels = {
  product = "qa"
  role    = "postgres"
  name    = "pgdb-replica"
}



postges-settings = {
  database_version = "POSTGRES_11"
  // availability_type = Zonal or regional
  availability_type        = "ZONAL"
  read_replica_name_suffix = "-replica"
  // Read this to understand tiers - https://cloud.google.com/sql/docs/postgres/create-instance
  tier                     = "db-custom-8-16384"
  //The type of data disk: PD_SSD (default) or PD_HDD.
  name            = "0"
  replica_zone    = "b"
  disk_autoresize = "true"
  disk_size       = "50"
  disk_type       = "PD_HDD"
  create_timeout  = "60m"
  update_timeout  = "30m"
  delete_timeout  = "60m"
  require_ssl     = false

}

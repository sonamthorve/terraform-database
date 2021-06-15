//gcp project
project    = "fin-authentic1-cug01-dev"
project_id = "fin-authentic1-cug01-dev"
//Region
region = "us-central1"
//vpc
network_name = "default"
//server/instance name
pg_ha_name = "authentic-pgdb-inst"
//Primary database
db_name       = "authentic-pg"
database_zone = "c"

////////// Need to put this in  a vault, uncommend in case you want to create a user through terraform
db_user     = "authentic"
db_password = "aut38t1c1a2c"

db_user2 = "fssre1"
//Optional
db_password2 = "aut38t1c1a2c"


pg_ha_external_ip_range = "0.0.0.0/0"


postges-settings = {
  database_version = "POSTGRES_11"
  // availability_type = Zonal or region
  availability_type        = "ZONAL"
  read_replica_name_suffix = "-replica"
  // Read this to understand tiers - https://cloud.google.com/sql/docs/postgres/create-instance
  tier                     = "db-custom-2-7680"
  read_replica_name_suffix = "-replica"
  //The type of data disk: PD_SSD (default) or PD_HDD.
  disk_type      = "PD_HDD"
  create_timeout = "60m"
  update_timeout = "30m"
  delete_timeout = "60m"
  require_ssl    = false

}

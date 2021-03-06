atlas_public_key      = ""
atlas_private_key     = ""
db_user               = ""
db_password           = ""
mongo_cluster_enabled = true
mongo_user_enabled    = true
mongo_config_enabled  = false // set this value true when you are using cluster_type is 'GEOSHARDED' and when instance size is greater or equal to M30

cluster_name       = "cluster1"
atlas_project_name = "project1"
mongo_inst = {
  cluster_instance_size_name   = "M10"
  zone_name                    = "zone 1"
  atlas_region                 = "CENTRAL_US"
  cluster_type                 = "REPLICASET"
  db_name                      = "firstdb"
  collection_name              = "default"
  custom_shard_key             = "key1"
  db_admin                     = "admin"
  role_name                    = "readWrite"
  num_shards                   = 1
  electable_nodes              = 3
  priority                     = 7
  read_only_nodes              = 0
  backup_enabled               = false
  provider_backup_enabled      = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "4.2"
  provider_name                = "GCP"
  disk_size_gb                 = 10
  environment                  = "qa"
  label_key1                   = "environment"
  label_key2                   = "project-name"
}

cidr_block_enabled    = false
single_ip_enabled     = false
mongo_cluster_enabled = true
mongo_user_enabled    = true
mongo_config_enabled  = true // set this value true when cluster_type is GEOSHARDED or instance_size_name is greter or equal to M30

//Below values are need to be harcodede in this file as per requirment 
cluster_name = "cxmarketing-cluster"

//whitelisting IP's
access_cidr_block = ""
single_ip         = ""
mongo_inst = {
  //mongo-instance-settings  
  cluster_instance_size_name   = "M10"        // It can be M10, M20 as per requirment 
  cluster_type                 = "REPLICASET" //REPLICASET or GEOSHARDED
  atlas_region                 = "CENTRAL_US"
  zone_name                    = "zone 1"
  num_shards                   = "1"
  provider_backup_enabled      = "true" //we can set true vlaue for  either provider_backup_enabled or backup_enabled at atlas sied
  auto_scaling_disk_gb_enabled = "true"
  mongo_db_major_version       = "4.2"
  provider_name                = "GCP" //Provider can be AWS, GCP, AZURE
  disk_size_gb                 = "10"
  electable_nodes              = 3
  priority                     = 7
  read_only_nodes              = 0
  backup_enabled               = false // we can set true value either provider_backup_enabled or backup_enabled from atlas side but recommendation is to set this false. Deprecated. 


  //mongo database settings
  db_name          = "cxmdb"
  collection_name  = "cxmdb-collection"
  custom_shard_key = "key1"
  db_admin         = "admin"
  role_name        = "readWrite"

  //mongo-lables
  environment = "qa" //It can be QA, DEV, Staging
  label_key1  = "environment"
  label_key2  = "project-name"
}

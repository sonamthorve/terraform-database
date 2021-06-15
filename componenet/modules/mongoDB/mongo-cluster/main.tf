# Define the MongoDB Atlas Provider
provider "mongodbatlas" {
  public_key  = var.atlas_public_key
  private_key = var.atlas_private_key
}

data "mongodbatlas_project" "project" {
  name = var.atlas_project_name
}

resource "mongodbatlas_cluster" "mongo-cluster" {

  count                  = var.mongo_cluster_enabled == true ? 1 : 0
  project_id             = data.mongodbatlas_project.project.id
  name                   = var.cluster_name
  mongo_db_major_version = var.mongo_inst["mongo_db_major_version"]
  backup_enabled         = var.mongo_inst["backup_enabled"]

  //provider settings
  provider_backup_enabled      = var.mongo_inst["provider_backup_enabled"]
  auto_scaling_disk_gb_enabled = var.mongo_inst["auto_scaling_disk_gb_enabled"]
  provider_name                = var.mongo_inst["provider_name"]
  disk_size_gb                 = var.mongo_inst["disk_size_gb"]
  provider_instance_size_name  = var.mongo_inst["cluster_instance_size_name"]
  cluster_type                 = var.mongo_inst["cluster_type"]

  replication_specs {
    zone_name  = var.mongo_inst["zone_name"]
    num_shards = var.mongo_inst["num_shards"]
    regions_config {
      region_name     = var.mongo_inst["atlas_region"]
      electable_nodes = var.mongo_inst["electable_nodes"]
      priority        = var.mongo_inst["priority"]
      read_only_nodes = var.mongo_inst["read_only_nodes"]
    }
  }

  labels {
    key   = var.mongo_inst["label_key1"]
    value = var.mongo_inst["environment"]
  }
  labels {
    key   = var.mongo_inst["label_key2"]
    value = var.atlas_project_name
  }
  lifecycle {
    ignore_changes = [disk_size_gb]
  }
}

resource "mongodbatlas_global_cluster_config" "config" {
  depends_on = [mongodbatlas_cluster.mongo-cluster]

  count = var.mongo_cluster_enabled == true && var.mongo_config_enabled == true ? 1 : 0

  project_id   = data.mongodbatlas_project.project.id
  cluster_name = var.cluster_name

  managed_namespaces {
    db               = var.mongo_inst["db_name"]
    collection       = var.mongo_inst["collection_name"]
    custom_shard_key = var.mongo_inst["custom_shard_key"]
  }
}

# Create a Database User
resource "mongodbatlas_database_user" "db-user" {
  count = var.mongo_user_enabled == true ? 1 : 0

  username           = var.db_user
  password           = var.db_password
  project_id         = data.mongodbatlas_project.project.id
  auth_database_name = var.mongo_inst["db_admin"]

  roles {
    role_name     = var.mongo_inst["role_name"]
    database_name = var.mongo_inst["db_name"]
  }

  scopes {
    name = var.cluster_name
    type = "CLUSTER"
  }
}

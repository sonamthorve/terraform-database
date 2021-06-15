// mongodb atlas public and private keys are coming from GCP secrets
provider "mongodbatlas" {
  public_key  = var.mongodb_atlas_public_key
  private_key = var.mongodb_atlas_private_key
}

module "mongoDB-ip-whitelist" {
   source = "../../sreg-modules/mongoDB/mongo-ip-whitelist"
  
  atlas_public_key   = var.mongodb_atlas_public_key
  atlas_private_key  = var.mongodb_atlas_private_key
  cidr_block_enabled = var.cidr_block_enabled
  single_ip_enabled  = var.single_ip_enabled
  access_cidr_block  = var.access_cidr_block
  single_ip          = var.single_ip
  atlas_project_name = var.atlas_project_name

}

module "mongoDB-cluster" {
  source = "../../sreg-modules/mongoDB/mongo-cluster"
  
  cluster_name          = "${var.cluster_name}-${var.deployment_id}"
  atlas_public_key      = var.mongodb_atlas_public_key
  atlas_private_key     = var.mongodb_atlas_private_key
  mongo_inst            = var.mongo_inst
  mongo_cluster_enabled = var.mongo_cluster_enabled
  mongo_config_enabled  = var.mongo_config_enabled
  mongo_user_enabled    = var.mongo_user_enabled
  db_user               = var.db_user
  db_password           = var.db_password
  atlas_project_name    = var.atlas_project_name
}

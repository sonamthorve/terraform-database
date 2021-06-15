//// mongodb atlas public and private keys are coming from GCP secrets
# Define the MongoDB Atlas Provider

provider "mongodbatlas" {
  org_atlas_public_key  = var.mongodb_atlas_public_key
  org_atlas_private_key = var.mongodb_atlas_private_key
}

module "mongoDB-project" {
  source = "../../sreg-modules/mongoDB/mongo-project"
  

  org_atlas_public_key  = var.mongodb_atlas_public_key
  org_atlas_private_key = var.mongodb_atlas_private_key
  atlas_cidr_block      = var.atlas_cidr_block // we will get this cidr values from _environment varible file depends on enviornment(e.g - dev, qa, perf)
  project               = var.project          //we will get this values from global variable file
  network               = var.network          //we will get this values from global variable file
  atlas_org_id          = var.atlas_org_id
  atlas_project_name    = var.atlas_project_name
  provider_name         = var.provider_name
}

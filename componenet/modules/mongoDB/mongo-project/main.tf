provider "mongodbatlas" {
  public_key  = var.org_atlas_public_key
  private_key = var.org_atlas_private_key
}

//Create a Project
resource "mongodbatlas_project" "atlas-project" {
  org_id = var.atlas_org_id
  name   = var.atlas_project_name
}

resource "mongodbatlas_network_container" "vpcpeer" {
  project_id       = mongodbatlas_project.atlas-project.id
  atlas_cidr_block = var.atlas_cidr_block
  provider_name    = var.provider_name
}

# Create the peering connection request
resource "mongodbatlas_network_peering" "mvpcpeer" {
  provider       = mongodbatlas
  project_id     = mongodbatlas_project.atlas-project.id
  container_id   = mongodbatlas_network_container.vpcpeer.container_id
  gcp_project_id = var.project
  network_name   = var.network
  provider_name  = var.provider_name
}

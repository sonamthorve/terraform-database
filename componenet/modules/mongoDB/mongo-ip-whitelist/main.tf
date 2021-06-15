provider "mongodbatlas" {
  public_key  = var.atlas_public_key
  private_key = var.atlas_private_key
}

data "mongodbatlas_project" "project" {
  name = var.atlas_project_name
}

resource "mongodbatlas_project_ip_access_list" "cidr_ip" {
  count = var.cidr_block_enabled == true ? 1 : 0

  project_id = data.mongodbatlas_project.project.id
  cidr_block = var.access_cidr_block
  comment    = "cidr block of GCP network"
}

resource "mongodbatlas_project_ip_access_list" "singleip" {
  count = var.single_ip_enabled == true ? 1 : 0

  project_id = data.mongodbatlas_project.project.id
  ip_address = var.single_ip
  comment    = "ip address of gcp resource"
}

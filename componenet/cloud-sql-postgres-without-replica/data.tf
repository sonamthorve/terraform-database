data "google_compute_network" "private_network" {
  name    = var.network
  project = var.network_project
}

data "google_compute_zones" "available" {
  region = var.region
 project=var.project

}



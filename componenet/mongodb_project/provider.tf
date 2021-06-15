terraform {
  backend "gcs" {
    bucket = var.gcs_default_bucket
    prefix = var.gcs_prefix
  }
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "0.8.2"
    }
  }
}
provider "google-beta" {
  project = var.project
  region  = var.region
}
provider "google" {
  project = var.project
  region  = var.region
}

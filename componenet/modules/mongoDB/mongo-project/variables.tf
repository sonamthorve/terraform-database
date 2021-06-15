variable "org_atlas_public_key" {
  description = "orgnazation public key"
  type        = string
}
variable "org_atlas_private_key" {
  description = "organization private key"
  type        = string
}
variable "project" {
  description = "name of gcp project"
}
variable "network" {
  description = "name of vpc_network"
}
variable "provider_name" {
  description = "name of the provider e.g GCP, AWS, AZURE"
}
variable "atlas_project_name" {
  description = "name of atlas project"
}
variable "atlas_org_id" {
  description = "organization ID in which you want to create your project"
}

variable "atlas_cidr_block" {
  description = "atlas CIDR block used for peering"
}

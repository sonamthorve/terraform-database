variable "mongodb_atlas_public_key" {
  description = "orgnazation public key"
  type        = string
}
variable "mongodb_atlas_private_key" {
  description = "organazation private key"
  type        = string
}
variable "provider_name" {
  description = "name of the provider e.g GCP, AWS, AZURE"
}
variable "component_name" {
  description = "componenet name for ansible"
  default     = "MongoDB"
}

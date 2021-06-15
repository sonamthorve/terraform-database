variable "cidr_block_enabled" {
  description = "if set to true it will add cidr block in whitelisting IP for connection"
}
variable "single_ip_enabled" {
  description = "if set to true it will add singleip in whitelisting IP for connection"
}
variable "atlas_public_key" {
  type        = string
  description = "MongoDB Atlas project Public Key"
}
variable "atlas_private_key" {
  type        = string
  description = "MongoDB Atlas project Private Key"
}
variable "atlas_project_name" {
  description = "name of atlas project"
}
variable "access_cidr_block" {
  description = "name of atlas project"
}
variable "single_ip" {
  description = "name of atlas project"
}

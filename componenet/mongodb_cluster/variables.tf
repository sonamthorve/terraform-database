variable "cidr_block_enabled" {
  description = "if set to true it will add cidr block in whitelisting IP for connection"
}
variable "single_ip_enabled" {
  description = "if set to true it will add singleip in whitelisting IP for connection"
}
variable "mongo_cluster_enabled" {
  description = "if set to true it will create cluster"
}
variable "mongo_config_enabled" {
  description = "if set to true it will cluster config"
}
variable "mongo_user_enabled" {
  description = "if set to true it will create user"
}
variable "mongodb_atlas_public_key" {
  type        = string
  description = "MongoDB Atlas project Public Key"
}
variable "mongodb_atlas_private_key" {
  type        = string
  description = "MongoDB Atlas project Private Key"
}
variable "mongo_inst" {
  type        = map(any)
  description = "Variables for mongoDb"
}
variable "cluster_name" {
  description = "cluster name of mongoDB"
}
variable "access_cidr_block" {
  description = "whitelisting ip cidr block"
}
variable "single_ip" {
  description = "whitelisting single ip"
}
variable "component_name" {
  description = "componenet name for ansible"
  default     = "MongoDB"
}
variable "db_user" {
  description = " mongodb user name"
}
variable "db_password" {
  description = "Mongo database user password"
}

variable "atlas_public_key" {
  type        = string
  description = "MongoDB Atlas project Public Key"
}
variable "atlas_private_key" {
  type        = string
  description = "MongoDB Atlas project Private Key"
}
variable "mongo_cluster_enabled" {
  description = "if set to true it will create cluster"
}
variable "mongo_config_enabled" {
  description = "if set to true it will create global cluster config"
}
variable "mongo_user_enabled" {
  description = "if set to true it will create user"
}
variable "cluster_name" {
  description = "name of the cluster"
}
variable "atlas_project_name" {
  description = "name of the cluster"
}
variable "db_user" {
  description = "Mongo database user name"
}
variable "db_password" {
  description = "Password of database user"
}
variable "mongo_inst" {
  type        = map(any)
  description = "variables for mongo instance"
}

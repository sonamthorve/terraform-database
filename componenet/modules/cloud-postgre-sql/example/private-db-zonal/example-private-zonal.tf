/**
 * Postgres simple database
 *  for HA database look at stashed folder
*/
data "google_compute_network" "private_network" {
  name    = var.network_name
  project = var.project_id
}

resource "google_compute_global_address" "private_ip_address" {

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = data.google_compute_network.private_network.id
  project       = var.project_id
}

resource "google_service_networking_connection" "private_vpc_connection" {

  network                 = data.google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

module "postgresql-db" {
  depends_on           = [google_service_networking_connection.private_vpc_connection]
  source               = "../../../cloud-postgre-sql"
  name                 = var.pg_ha_name
  random_instance_name = true
  database_version     = var.postges-settings["database_version"]
  create_timeout       = var.postges-settings["create_timeout"]
  update_timeout       = var.postges-settings["update_timeout"]
  delete_timeout       = var.postges-settings["delete_timeout"]
  availability_type    = var.postges-settings["availability_type"]


  project_id = var.project
  zone       = var.database_zone
  region     = var.region
  tier       = "db-f1-micro"

  user_name     = var.db_user
  user_password = var.db_password

  //In case you need to create a db uncommend below.
  //db_name = var.db_name

  ip_configuration = {
    ipv4_enabled    = "false"
    private_network = data.google_compute_network.private_network.id
    require_ssl     = var.require_ssl
    authorized_networks = [
      {
        name  = "cloudsql"
        value = "0.0.0.0/0"
      },
    ]
  }

}

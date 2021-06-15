# terraform-google-sql for PostgreSQL

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| activation\_policy | The activation policy for the master instance.Can be either `ALWAYS`, `NEVER` or `ON_DEMAND`. | string | `"ALWAYS"` | no |
| additional\_databases | A list of databases to be created in your cluster | object | `<list>` | no |
| additional\_users | A list of users to be created in your cluster | object | `<list>` | no |
| availability\_type | The availability type for the master instance.This is only used to set up high availability for the PostgreSQL instance. Can be either `ZONAL` or `REGIONAL`. | string | `"ZONAL"` | no |
| backup\_configuration | The backup_configuration settings subblock for the database setings | object | `<map>` | no |
| create\_timeout | The optional timout that is applied to limit long database creates. | string | `"10m"` | no |
| database\_flags | The database flags for the master instance. See [more details](https://cloud.google.com/sql/docs/postgres/flags) | object | `<list>` | no |
| database\_version | The database version to use | string | n/a | yes |
| db\_charset | The charset for the default database | string | `""` | no |
| db\_collation | The collation for the default database. Example: 'en_US.UTF8' | string | `""` | no |
| db\_name | The name of the default database to create | string | `"default"` | no |
| delete\_timeout | The optional timout that is applied to limit long database deletes. | string | `"10m"` | no |
| disk\_autoresize | Configuration to increase storage size. | bool | `"true"` | no |
| disk\_size | The disk size for the master instance. | string | `"10"` | no |
| disk\_type | The disk type for the master instance. | string | `"PD_SSD"` | no |
| encryption\_key\_name | The full path to the encryption key used for the CMEK disk encryption | string | `"null"` | no |
| ip\_configuration | The ip configuration for the master instances. | object | `<map>` | no |
| maintenance\_window\_day | The day of week (1-7) for the master instance maintenance. | number | `"1"` | no |
| maintenance\_window\_hour | The hour of day (0-23) maintenance window for the master instance maintenance. | number | `"23"` | no |
| maintenance\_window\_update\_track | The update track of maintenance window for the master instance maintenance.Can be either `canary` or `stable`. | string | `"canary"` | no |
| module\_depends\_on | List of modules or resources this module depends on. | list(any) | `<list>` | no |
| name | The name of the Cloud SQL resources | string | n/a | yes |
| pricing\_plan | The pricing plan for the master instance. | string | `"PER_USE"` | no |
| project\_id | The project ID to manage the Cloud SQL resources | string | n/a | yes |
| random\_instance\_name | Sets random suffix at the end of the Cloud SQL resource name | bool | `"false"` | no |
| read\_replica\_name\_suffix | The optional suffix to add to the read instance name | string | `""` | no |
| read\_replicas | List of read replicas to create | object | `<list>` | no |
| region | The region of the Cloud SQL resources | string | `"us-central1"` | no |
| tier | The tier for the master instance. | string | `"db-f1-micro"` | no |
| update\_timeout | The optional timout that is applied to limit long database updates. | string | `"10m"` | no |
| user\_labels | The key/value labels for the master instances. | map(string) | `<map>` | no |
| user\_name | The name of the default user | string | `"default"` | no |
| user\_password | The password for the default user. If not set, a random one will be generated and available in the generated_user_password output variable. | string | `""` | no |
| zone | The zone for the master instance, it should be something like: `a`, `c`. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| generated\_user\_password | The auto generated default user password if not input password was provided |
| instance\_connection\_name | The connection name of the master instance to be used in connection strings |
| instance\_first\_ip\_address | The first IPv4 address of the addresses assigned. |
| instance\_ip\_address | The IPv4 address assigned for the master instance |
| instance\_name | The instance name for the master instance |
| instance\_self\_link | The URI of the master instance |
| instance\_server\_ca\_cert | The CA certificate information used to connect to the SQL instance via SSL |
| instance\_service\_account\_email\_address | The service account email address assigned to the master instance |
| private\_ip\_address | The first private (PRIVATE) IPv4 address assigned for the master instance |
| public\_ip\_address | The first public (PRIMARY) IPv4 address assigned for the master instance |
| read\_replica\_instance\_names | The instance names for the read replica instances |
| replicas\_instance\_connection\_names | The connection names of the replica instances to be used in connection strings |
| replicas\_instance\_first\_ip\_addresses | The first IPv4 addresses of the addresses assigned for the replica instances |
| replicas\_instance\_self\_links | The URIs of the replica instances |
| replicas\_instance\_server\_ca\_certs | The CA certificates information used to connect to the replica instances via SSL |
| replicas\_instance\_service\_account\_email\_addresses | The service account email addresses assigned to the replica instances |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### Example (Simple DB)
```
data "google_compute_network" "private_network" {
  name = var.network_name
}


resource "google_compute_global_address" "private_ip_address" {

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = data.google_compute_network.private_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {

  network                 = data.google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

module "postgresql-db" {
  depends_on           = [google_service_networking_connection.private_vpc_connection]
  source               = "./modules/gcp/terraform-postgresql"
  name                 = var.pg_ha_name
  random_instance_name = true
  database_version     = var.postges-settings["database_version"]
  create_timeout       = var.postges-settings["create_timeout"]
  update_timeout       = var.postges-settings["update_timeout"]
  delete_timeout       = var.postges-settings["delete_timeout"]


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

```
### Sample 2 (HA)
```
/**
 * Postgres high availability
*/
//https://github.com/terraform-google-modules/terraform-google-sql-db/blob/master/examples/postgresql-ha/variables.tf
locals {
  read_replica_ip_configuration = {
    ipv4_enabled    = true
    require_ssl     = var.require_ssl
    private_network = null
    authorized_networks = [
      {
        name  = "${var.project_id}-cidr"
        value = var.pg_ha_external_ip_range
      },
    ]
  }
}
module "postgresql-db-ha" {
  source               = "./modules/gcp/terraform-postgresql"
  name                 = var.pg_ha_name
  random_instance_name = true
  project_id           = var.project
  database_version     = var.postges-settings["database_version"]
  region               = var.region

  // Master configurations
  // Look at this https://cloud.google.com/sql/docs/postgres/create-instance
  tier = var.postges-settings["tier"]
  zone = var.database_zone

  availability_type               = var.postges-settings["availability_type"]
  maintenance_window_day          = 7
  maintenance_window_hour         = 12
  maintenance_window_update_track = "stable"

  database_flags = [{ name = "autovacuum", value = "off" }]

  user_labels = {
    name = "authentic"
  }

  ip_configuration = {
    ipv4_enabled    = true
    require_ssl     = var.require_ssl
    private_network = null
    authorized_networks = [
      {
        name  = "${var.project_id}-cidr"
        value = var.pg_ha_external_ip_range
      },
    ]
  }

  backup_configuration = {
    enabled    = false
    start_time = "20:55"
    location   = null
  }

  /*****************************************/
  // Below add the default authentic db
  db_name       = var.pg_ha_name
  db_charset    = "UTF8"
  db_collation  = "en_US.UTF8"
  user_name     = var.db_user
  user_password = var.db_password

  // Read replica configurations
  // Important Note  Uncommend below and add more replica
  /*************************************************************
  read_replica_name_suffix = var.postges-settings.read_replica_name_suffix
  read_replicas = [
    {
      name             = "0"
      zone             = "us-central1-a"
      tier             = var.postges-settings["tier"]
      ip_configuration = local.read_replica_ip_configuration
      database_flags   = [{ name = "autovacuum", value = "off" }]
      disk_autoresize  = null
      disk_size        = null
      disk_type        = var.postges-settings["disk_type"]
      user_labels      = { name = "authentic" }
    },
  ]
**********************************************************************/
  //*************** Uncomment below to add more database ******************/
  //additional_databases = [
  //  {
  //    name      = "${var.pg_ha_name}-additional"
  //    charset   = "UTF8"
  //    collation = "en_US.UTF8"
  //  },
  //]
  //********************/
}
```

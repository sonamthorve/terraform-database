PostgreSQL is a powerful, open source object-relational database system that uses and extends the SQL language combined with many features that safely store and scale the most complicated data workloads.

# terraform-google-sql for PostgreSQL
 This componenet will create postgresql instance with replica configuration. It uses cloud-sql-postgres module which has all resource created which is required for this   componenet to create postgres instance. 

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
| database\_version | The database version to use, e.g POSTGRES_11, POSTGRES_12, POSTGRES_10| string | n/a | yes |
| db\_charset | The charset for the default database | string | `""` | no |
| db\_collation | The collation for the default database. Example: 'en_US.UTF8' | string | `""` | no |
| db\_name | The name of the default database to create | string | `"default"` | no |
| delete\_timeout | The optional timout that is applied to limit long database deletes. | string | `"10m"` | no |
| disk\_autoresize | Configuration to increase storage size. | bool | `"true"` | no |
| disk\_size | The disk size for the master instance. | string | `"10"` | no |
| disk\_type | The disk type for the master instance. | string | `"PD_SSD"` | no |
| encryption\_key\_name | The full path to the encryption key used for the CMEK disk encryption | string | `"null"` | no |
| ip\_configuration | The ip configuration for the master instances. Whether this Cloud SQL instance should be assigned a public/private IPV4 address. "ipv4_enabled" must be    enabled or a private_network must be configured."require_ssl" - (Optional) Whether SSL connections over IP are enforced or not.| object |'"map"'| no |
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
| tier | The tier for the master instance. Read this to understand tiers - https://cloud.google.com/sql/docs/postgres/create-instance. You can set custome tier e.g -"db-custom-8-16384" it will create 8 vCPUs 16 GB memory | string | `"db-f1-micro"` | no |
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

Note-  If you have set "max_connection" flag then check for more details of flags -See https://cloud.google.com/sql/docs/postgres/flags .For flag "max_connection" it is depends on tier- check limits here https://cloud.google.com/sql/docs/postgres/quotas 

#Note: CloudSQL provides disk autoresize feature which can cause a Terraform configuration drift due to the value in disk_size variable, and hence any updates to this variable is ignored in the Terraform lifecycle.

#Note - Read replica can not be smaller(tier) than primary Instance. it should be always greater or same as primary instance. While updating tier you need to first update the replica manually from GCP portal and then you can update primary instance using terraform. 

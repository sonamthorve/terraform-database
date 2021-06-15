# terraform- MongoDB
MongoDB is a document-oriented NoSQL database used for high volume data storage. Instead of using tables and rows as in the traditional relational databases, MongoDB makes use of collections and documents. Documents consist of key-value pairs which are the basic unit of data in MongoDB. Collections contain sets of documents and function which is the equivalent of relational database tables
###

It has three modules-<br/>
            <Markup/> * **mongo-project**<br/>
                      * **mongo-cluster**<br/>
                      * **mong-ip-whitelist**

**mongo-project** - To create project and vpc peering required for connection.<br/>
**mongo_cluster** - To create cluster inside project,, with database, collection and user configuration.<br/>
**mongo-ip-whitelist** - To add whitelist IP's or cidr block for connection.<br/>

###


Organization- First need to create organization before creating projects and other things. So, you will get organization id to create project. 
              you need to create organization level private and public keys to create project.
                        
                           
Projects - organization must be created before creating project, because you need org_id to create project within that particular organization. you can create multiple projects inside one organization. create project level public & private keys.

clusters - for creating cluster project should be created first to get project_id to create cluster within that project. you need to create project level public and private keys to create cluster . You can create multiple clusters in one project.

databases/collections - In cluster then we can create databases and collections.


|   Name    | Description | Type | Required |
| ------------- |:-------------:| -----:|------:|
|atlas_private_key|It can be oranazation key or project key.To create project organazation level key used|string|yes|
|atls_public_key|It can be oranazation key or project key.To create project organazation level key used|string|yes|
|name|The name of the project you want to create|string|yes|
|org_id|The ID of the organization you want to create the project within|string|yes|
|project_id|The unique ID for the MongoDB Atlas project|string|yes|
|conatainer_id|Unique identifier of the MongoDB Atlas container for the provider (GCP) or provider/region (AWS, AZURE). You can create an MongoDB Atlas container using the network_container resource or it can be obtained from the cluster returned values if a cluster has been created before the first container|string|yes|
|provider_name|Cloud provider to whom the peering connection is being made. (Possible Values AWS, AZURE, GCP)|string|yes|
|gcp_proejct_id|GCP project ID of the owner of the network peer|string||yes|
|network_name|Name of the network peer to which Atlas connects|string|yes|
|atlas_cidr_block|CIDR block that Atlas uses for the Network Peering containers in your project. Atlas uses the specified CIDR block for all other Network Peering connections created in the project.|string|yes|
|auth_database_name|Database against which Atlas authenticates the user. A user must provide both a username and authentication database to log into MongoDB|string|yes|
|roles|List of user’s roles and the databases collections on which the roles apply. A role allows the user to perform particular actions on the specified database. A role on the admin database can include privileges that apply to the other databases as well. See Roles below for more details|string|yes|
|username|Username for authenticating to MongoDB|string|yes|
|password|User's initial password. A value is required to create the database user, however the argument but may be removed from your Terraform configuration after user creation without impacting the user, password or Terraform management|string|yes|
|role_name|Name of the role to grant. See Create a Database User roles.roleName for valid values and restrictions|string|yes|
|database_name|Database on which the user has the specified role. A role on the admin database can include privileges that apply to the other databases|string|yes|
|collection_name|Collection for which the role applies. You can specify a collection for the read and readWrite roles. If you do not specify a collection for read and readWrite, the role applies to all collections in the database (excluding some collections in the system. database)|string|no|
|collection|The name of the collection associated with the managed namespace|string|yes|
|custom_shard_key|he custom shard key for the collection. Global Clusters require a compound shard key consisting of a location field and a user-selected second key, the custom shard key|string|yes|
|db|The name of the database containing the collection|string|yes|
|location|he ISO location code to which you want to map a zone in your Global Cluster. You can find a list of all supported location codes here|string|yes|
|zone|he name of the zone in your Global Cluster that you want to map to location|string|yes|
|provider_instance_size_name|Atlas provides different instance sizes, each with a default storage capacity and RAM size. The instance size you select is used for all the data-bearing servers in your cluster. See Create a Cluster|string|yes|
|auto_scaling_disk_gb_enabled| Specifies whether disk auto-scaling is enabled. The default is true|string|no|
|backup_enabled|Set to true to enable Atlas legacy backups for the cluster. Important - MongoDB deprecated the Legacy Backup feature. Clusters that use Legacy Backup can continue to use it. MongoDB recommends using Cloud Backups|string|no|
|disk_size_gb|Capacity, in gigabytes, of the host’s root volume. Increase this number to add capacity, up to a maximum possible value of 4096 (i.e., 4 TB). This value must be a positive integer|string|no|
|mongo_db_major_version|Version of the cluster to deploy. Atlas supports the following MongoDB versions for M10+ clusters: 3.6, 4.0, or 4.2. You must set this value to 4.2 if provider_instance_size_name is either M2 or M5|string|no|
|replication_factor|Number of replica set members. Each member keeps a copy of your databases, providing high availability and data redundancy. The possible values are 3, 5, or 7. The default value is 3|string|no|
|num_shard|Number of shards to deploy in the specified zone, minimum 1|string|yes|
|region|Physical location of your MongoDB cluster. The region you choose can affect network latency for clients accessing your databases. Requires the Atlas region name, see the reference list for AWS, GCP, Azure|string|no|

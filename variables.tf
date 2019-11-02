variable "name" {
  type        = string
  description = "The Name of the application or solution  (e.g. `bastion` or `portal`)"
}

variable "namespace" {
  type        = string
  description = "Namespace (e.g. `eg` or `cp`)"
}

variable "stage" {
  type        = string
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
}

variable "dns_zone_id" {
  type        = string
  default     = ""
  description = "The ID of the DNS Zone in Route53 where a new DNS record will be created for the DB host name"
}

variable "host_name" {
  type        = string
  default     = "db"
  description = "The DB host name created in Route53"
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "he IDs of the security groups from which to allow `ingress` traffic to the DB instance"
}

variable "database_name" {
  type        = string
  description = "The name of the database to create when the DB instance is created"
}

variable "database_user" {
  type        = string
  default     = ""
  description = "(Required unless a `snapshot_identifier` or `replicate_source_db` is provided) Username for the master DB user"
}

variable "database_password" {
  type        = string
  default     = ""
  description = "(Required unless a snapshot_identifier or replicate_source_db is provided) Password for the master DB user"
}

variable "database_port" {
  description = "Database port (_e.g._ `3306` for `MySQL`). Used in the DB Security Group to allow access to the DB instance from the provided `security_group_ids`"
}

variable "multi_az" {
  type        = string
  description = "Set to true if multi AZ deployment must be supported"
  default     = "false"
}

variable "storage_type" {
  type        = string
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)."
  default     = "standard"
}

variable "storage_encrypted" {
  type        = string
  description = "(Optional) Specifies whether the DB instance is encrypted. The default is false if not specified."
  default     = "false"
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'. Default is 0 if rds storage type is not 'io1'"
  default     = "0"
}

variable "allocated_storage" {
  description = "The allocated storage in GBs"
  # Number, e.g. 10
}

variable "engine" {
  type        = string
  description = "Database engine type"
  # http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html
  # - mysql
  # - postgres
  # - oracle-*
  # - sqlserver-*
}

variable "engine_version" {
  type        = string
  description = "Database engine version, depends on engine type"
  # http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html
}

variable "instance_class" {
  type        = string
  description = "Class of RDS instance"
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html
}

# This is for custom parameters to be passed to the DB
# We're "cloning" default ones, but we need to specify which should be copied
variable "db_parameter_group" {
  type        = string
  description = "Parameter group, depends on DB engine used"
  # "mysql5.6"
  # "postgres9.5"
}

variable "publicly_accessible" {
  type        = string
  description = "Determines if database can be publicly available (NOT recommended)"
  default     = "false"
}

variable "subnet_ids" {
  description = "List of subnets for the DB"
  type        = list(string)
}

variable "vpc_id" {
  type        = string
  description = "VPC ID the DB instance will be created in"
}

variable "auto_minor_version_upgrade" {
  type        = string
  description = "Allow automated minor version upgrade (e.g. from Postgres 9.5.3 to Postgres 9.5.4)"
  default     = "true"
}

variable "allow_major_version_upgrade" {
  type        = string
  description = "Allow major version upgrade"
  default     = "false"
}

variable "apply_immediately" {
  type        = string
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = "false"
}

variable "maintenance_window" {
  type        = string
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi' UTC "
  default     = "Mon:03:00-Mon:04:00"
}

variable "skip_final_snapshot" {
  type        = string
  description = "If true (default), no snapshot will be made before deleting DB"
  default     = "true"
}

variable "copy_tags_to_snapshot" {
  type        = string
  description = "Copy tags from DB to a snapshot"
  default     = "true"
}

variable "backup_retention_period" {
  description = "Backup retention period in days. Must be > 0 to enable backups"
  default     = 0
}

variable "backup_window" {
  type        = string
  description = "When AWS can perform DB snapshots, can't overlap with maintenance window"
  default     = "22:00-03:00"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "db_parameter" {
  type        = list(object({ name=string, value=string }))
  default     = []
  description = "A list of DB parameters to apply. Note that parameters may differ from a DB family to another"
}

variable "snapshot_identifier" {
  type        = string
  description = "Snapshot identifier e.g: rds:production-2015-06-26-06-05. If specified, the module create cluster from the snapshot"
  default     = ""
}

variable "final_snapshot_identifier" {
  type        = string
  description = "Final snapshot identifier e.g.: some-db-final-snapshot-2015-06-26-06-05"
  default     = ""
}

variable "parameter_group_name" {
  type        = string
  description = "Name of the DB parameter group to associate"
  default     = ""
}

variable "deletion_protection" {
  type        = string
  description = "(Optional) If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false."
  default     = "false"
}

variable "iam_database_authentication_enabled" {
  type        = string
  description = "(Optional) Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled."
  default     = "false"
}

variable "monitoring_interval" {
  type        = string
  description = "(Optional) The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  default     = "0"
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
  default     = ""
}

variable "performance_insights_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether Performance Insights are enabled."
}

variable "performance_insights_kms_key_id" {
  type        = string
  default     = null
  description = "The ARN for the KMS key to encrypt Performance Insights data. Once KMS key is set, it can never be changed."
}

variable "performance_insights_retention_period" {
  type        = number
  default     = 7
  description = "The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years)."
}

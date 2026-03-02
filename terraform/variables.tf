variable "service_account_key_file" {
  description = "Service account key file path"
  default     = "/Users/mew/Desktop/my_project_05/keys/service_account.json"
}

variable "project_id" {
  description = "Google Cloud project ID"
  default     = "my-project-05-488906"
}

variable "gcs_bucket_name" {
  description = "Google Cloud Storage bucket name"
  default     = "my-project-bucket-05-488906"
}

variable "region" {
  description = "Google Cloud region"
  default     = "us-central1"
}

variable "zone" {
  description = "Google Cloud zone"
  default     = "us-central1-a"
}

variable "location" {
  description = "Google Cloud location"
  default     = "US"
}

variable "bigquery_bronze" {
  description = "BigQuery dataset name for bronze layer"
  default     = "bronze"
}

variable "bigquery_silver" {
  description = "BigQuery dataset name for silver layer"
  default     = "silver"
}

variable "bigquery_gold" {
  description = "BigQuery dataset name for gold layer"
  default     = "gold"
}

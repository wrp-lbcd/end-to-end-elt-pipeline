# Terraform configuration for creating a GCS bucket
provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
credentials = file(var.service_account_key_file)
}

# Create GCS bucket
resource "google_storage_bucket" "gcs_bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true

  public_access_prevention = "enforced"
}

# Create BigQuery datasets for bronze, silver, and gold layers
resource "google_bigquery_dataset" "bronze_dataset" {
  dataset_id                  = var.bigquery_bronze
  location                    = var.location
}

resource "google_bigquery_dataset" "silver_dataset" {
  dataset_id                  = var.bigquery_silver
  location                    = var.location
}

resource "google_bigquery_dataset" "gold_dataset" {
  dataset_id                  = var.bigquery_gold
  location                    = var.location
}
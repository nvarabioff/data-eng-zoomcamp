variable "credentials" {
  description = "The path to the GCP service account key file"
  type        = string
  default     = "./keys/terraform-runner.json"
}

variable "project" {
  description = "The GCP project ID to deploy resources in"
  type        = string
  default     = "terraform-demo-468023"
}

variable "region" {
  description = "The GCP region to deploy resources in"
  type        = string
  default     = "us-central1"
}

variable "location" {
  description = "The GCP region to deploy resources in"
  type        = string
  default     = "US"
}

variable "bq_dataset_name" {
  description = "The name of the BigQuery dataset to create"
  type        = string
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "The name of the Google Cloud Storage bucket to create"
  type        = string
  default     = "terraform-demo-468023-terra-bucket"
}

variable "gcs_storage_class" {
  description = "The storage class for the Google Cloud Storage bucket"
  type        = string
  default     = "STANDARD"
}
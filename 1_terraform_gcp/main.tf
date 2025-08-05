terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.46.0"
    }
  }
}

provider "google" {
  project     = "terraform-demo-468023"
  region      = "us-central1"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = "terraform-demo-468023"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
        age = 1
    }
    action {
        type = "AbortIncompleteMultipartUpload"
    }
  }
}
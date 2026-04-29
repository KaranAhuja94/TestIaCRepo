terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.16.0"
    }
  }
}

provider "google" {
  # Configuration options
}

resource "google_kms_key_ring" "keyring" {
  name     = "keyring-example"
  location = "global"
}

resource "google_kms_crypto_key" "test-key" {
  name     = "test-key"
  key_ring = google_kms_key_ring.keyring.id
  #control id 52005 - Pass
  rotation_period = "7776000s"
  labels = {
    yor_trace = "d9c3bed5-e4eb-46c3-9969-20293afc5653"
  }
}

resource "google_storage_bucket" "test-bucket" {
  name     = "test-bucket"
  location = "EU"
  #control id 52010 - Fail
  versioning {
    enabled = false
  }
  labels = {
    yor_trace = "e9bd5462-5f9a-4c92-8a55-eb191361fc0c"
  }
}
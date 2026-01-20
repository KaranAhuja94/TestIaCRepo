terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
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
  name = "test-key"
  key_ring = google_kms_key_ring.keyring.id
  #control id 52005 - Pass
  rotation_period = "7776000s"
}

resource "google_storage_bucket" "test-bucket" {
  name = "test-bucket"
  location = "EU"
  #control id 52010 - Fail
  versioning {
    enabled = false
  }
}
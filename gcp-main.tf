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
    yor_trace = "10e28c92-1404-47c8-a7cf-ed1a5fb09d1f"
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
    yor_trace = "209b9e49-eae8-4924-92ee-c98b1532e8fa"
  }
}
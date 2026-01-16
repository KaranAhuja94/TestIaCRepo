terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.19.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "azurerm" {
  subscription_id = "1d767489-da0c-4948-a285-bf2c708c0586"
  features {
  }
}

resource "aws_s3_bucket" "s3-logging-bucket" {
  bucket = "test-logging-bucket-15012026"
}

resource "aws_s3_bucket" "test-s3-bucket" {
  bucket = "test-bucket-15012026"
  #control id 47 - Pass
  logging {
    target_bucket = aws_s3_bucket.s3-logging-bucket.bucket
    target_prefix = "logs/"
  }
  # control id 48 - Fail
  versioning {
    enabled = false
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "test-iam-role" {
  name               = "lambda-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_lambda_function" "test-lambda-function" {
  function_name = "test-lambda-function-15012026"
  role          = aws_iam_role.test-iam-role.arn
  # control id 97 - Pass
  tracing_config {
    mode = "Active"
  }
}

resource "aws_db_instance" "test-db-instance" {
  instance_class = "db.t3.micro"
  # control id 55 - Fail
  auto_minor_version_upgrade = false
}

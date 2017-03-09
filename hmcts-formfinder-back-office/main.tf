provider "aws" {
  alias = "prod"

  region     = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

resource "aws_s3_bucket" "hmcts-formfinder-prod" {
  provider = "aws.prod"
  bucket = "${var.prod_bucket_name}"
  acl    = "private"
  tags {
    Environment = "prod"
    DeploymentRepo = "${var.stack_repo}"
  }
}


resource "aws_s3_bucket" "hmcts-formfinder-staging" {
  provider = "aws.prod"
  bucket = "${var.staging_bucket_name}"
  acl    = "private"
  tags {
    Environment = "staging"
    DeploymentRepo = "${var.stack_repo}"
  }
}


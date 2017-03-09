
# STAGING
resource "aws_iam_user" "s3_staging_user" {
    provider = "aws.prod"
    name = "APP_s3_hmcts_formfinder_back_office_staging"
    path = "/"
}

resource "aws_iam_access_key" "s3_staging_user" {
    provider = "aws.prod"
    user = "${aws_iam_user.s3_staging_user.name}"
}

resource "aws_iam_user_policy" "s3_staging_rw" {
    provider = "aws.prod"
    name = "ReadWriteDocumentsBucket"
    user = "${aws_iam_user.s3_staging_user.name}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
                "s3:Get*",
                "s3:List*",
                "s3:Put*",
                "s3:Delete*"
      ],
      "Effect": "Allow",
      "Resource": [
                    "${aws_s3_bucket.hmcts-formfinder-staging.arn}",
                    "${aws_s3_bucket.hmcts-formfinder-staging.arn}/*"

     ]
    }
  ]
}
EOF
}




# PROD
resource "aws_iam_user" "s3_prod_user" {
    provider = "aws.prod"
    name = "APP_s3_hmcts_formfinder_back_office_prod"
    path = "/"
}

resource "aws_iam_access_key" "s3_prod_user" {
    provider = "aws.prod"
    user = "${aws_iam_user.s3_prod_user.name}"
}

resource "aws_iam_user_policy" "s3_prod_rw" {
    provider = "aws.prod"
    name = "test"
    user = "${aws_iam_user.s3_prod_user.name}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
                "s3:Get*",
                "s3:List*",
                "s3:Put*",
                "s3:Delete*"
      ],
      "Effect": "Allow",
      "Resource": [
                    "${aws_s3_bucket.hmcts-formfinder-prod.arn}",
                    "${aws_s3_bucket.hmcts-formfinder-prod.arn}/*"

     ]
    }
  ]
}
EOF
}

output "key1" {
  value = "\nID = ${aws_iam_access_key.s3_prod_user.id}\nSECRET = ${aws_iam_access_key.s3_prod_user.secret}"
}
output "key2" {
  value = "\nID = ${aws_iam_access_key.s3_staging_user.id}\nSECRET = ${aws_iam_access_key.s3_staging_user.secret}"
}

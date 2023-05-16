resource "aws_s3_bucket" "cyware_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  tags = merge(var.commantags,
    {
      "Name" = "cyware-terraformstatefile"
    }
  )

}

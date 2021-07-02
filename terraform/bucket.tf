resource "aws_s3_bucket" "testbucket" {
  bucket = "the-station-test-bucket"
  acl    = "private"
}

resource "aws_s3_bucket_object" "obj1" {
  bucket = aws_s3_bucket.testbucket.id
  key    = "test1.txt"
  acl    = "private"
  source = local_file.file1.filename
}

resource "aws_s3_bucket_object" "obj2" {
  bucket = aws_s3_bucket.testbucket.id
  key    = "test2.txt"
  acl    = "private"
  source = local_file.file2.filename
}

resource "aws_s3_bucket_policy" "testbucket" {
  bucket = aws_s3_bucket.testbucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "TestBucketProtection"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.testbucket.arn,
          "${aws_s3_bucket.testbucket.arn}/*",
        ]
        Condition = {
          IpAddress = {
            "aws:SourceIp" = var.priv_sub
          }
        }
      },
    ]
  })
}

output "bucket_name" {
    value = aws_s3_bucket.testbucket.bucket_domain_name
}


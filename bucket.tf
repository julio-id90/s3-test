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


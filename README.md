# s3-test
terraform s3 file upload

**Assumptions:**

You have awscli already downloaded and configured under `~/.aws/credentials` and `~/.aws/config`

The aws profile used is `the-station` found in provider.tf

The bucket name `the-station-test-bucket` has been chosen because it's unique at the time I wrote this.

The Terraform version expected is v0.12.0+ (mine is v0.12.6)

You test it from a Linux computer with bash/dash like shell


# Running terraform.

clone the repo: `git clone git@github.com:julio-id90/s3-test.git` and `cd s3-test/`

Initialize Terraform: `terraform init`

Show the plan: `terraform plan`

Apply the plan: `terraform apply`


Verify the recently created resources by issuing: `aws s3 ls s3://the-station-test-bucket/ --profile the-station` which should return the list of files.

Download the files from the bucket (`aws s3 cp s3://the-station-test-bucket/test1.txt ../ --profile the-station`)

Dump it contents: `cat ../test[1-2].txt`

Destroy the recently created resources by issuing: `terraform destroy`

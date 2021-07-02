# s3-test and Serve
terraform s3 file upload and serve in HA mode

**Porpose:**

This script should create an s3 bucket and add 2 file objects to it: test1.txt and test2.txt which should content the file creation timestamp at terraform run
Those files should be secured to be seen just for the intances (via IAM role) which will serve the files through an application load balancer within a non default VPC. 
Instansces must be in the Private Subnet.

**Assumptions:**

You have awscli already downloaded and configured under `~/.aws/credentials` and `~/.aws/config`
The aws profile used here is `the-station` found in provider.tf
The bucket name `the-station-test-bucket` has been chosen because it's unique at the time I wrote this.
The Terraform version expected is v0.13.1+ (mine is v0.13.1)
You test it from a Linux computer with bash/dash like shell

# Running terraform.

clone the repo: `git clone git@github.com:julio-id90/s3-test.git` and `cd s3-test/terraform`

Initialize Terraform: `terraform init`

Show the plan: `terraform plan`

Apply the plan: `terraform apply`

This command should create:
- A `non Default VPC` - cidr: `192.168.32.0/25`
- A `NAT Gateway` with an `elastic IP address`
- An `Internet Gateway`
- Two `Subnets` with its `Routing Tables Associations`
    - `192.168.32.0/26  Public Subnet`
    - `192.168.32.64/26 Private Subnet`
- Two `EC2 Instances` in the `Private Subnet` (which should have `Traefik` installed and configured to serve the s3 files)
- An `ALB` with a `Target Group` pointing to the `EC2 Instances` `port 80`

Traefik is not yet installed the EC2 Instance (I'm using a defult blank one) and that's why I upload this to a `/terraform` forlder.
Now I'm working in a separate `/packer` directory whith the `AMI creation` with Traefik installed and configured to server the S3 files.
This last step is taking me longer than expected, I never have used Traefik before (In the past I have used Varnish, Nginx reverse proxy, Apache reverse proxy, HA-Proxy and KeepAlived but never Traefik) and I'm trying to figure out how it works and how the configuration is.
So, at this point I'm studing and learning a lot.


You can `Destroy` the recently created resources by issuing: `terraform destroy`


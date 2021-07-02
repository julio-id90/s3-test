provider "aws" {
  region = var.region
  profile = "the-station"
  version = "~> 3.0"
}

provider "local" {

}


terraform {
  backend "s3" {
    bucket       = "terraform-state-h3"
    key          = "demostate/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true # S3 native locking, stops two parallel runs on the same state
  }
}

resource "null_resource" "test" {}
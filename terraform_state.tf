terraform {
  backend "s3" {
    bucket  = "istox-state-bucket"
    encrypt = "true"
    key     = "state/terraform.tfstate"
    region  = "ap-southeast-1"
  }
}

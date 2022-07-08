terraform {
  backend "s3" {
    bucket = "my-terraform-bucket1"
    key    = "tfstate"
    region = "ap-southeast-1"
  }
}
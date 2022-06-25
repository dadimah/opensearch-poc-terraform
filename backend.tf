# terraform {
#   backend "s3" {
#     bucket = "opensearch-poc-terraform-s3"
#     key    = "state.tfstate"
#     region = var.region
#   }
# }
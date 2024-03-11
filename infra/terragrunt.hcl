remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "opentofu-state-c3lavk0"
    key = "loncar_net/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "opentofu-state-c3lavk0-locks"
  }
}

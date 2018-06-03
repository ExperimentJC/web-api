variable "image" {}

provider "aws" {
  region = "us-west-1"
}

terraform {
  backend "s3" {
    bucket = "halo-tfstate-primary.aws.hautelook.net"
    key    = "erp-members/members-api/prod/terraform.tfstate"
    region = "us-west-1"
  }
}

data "terraform_remote_state" "clusters" {
  backend = "s3"

  config {
    bucket = "halo-tfstate-primary.aws.hautelook.net"
    key    = "platform-ecs-clusters/terraform.tfstate"
    region = "us-west-1"
  }
}

module "ecs_service" {
  source           = "../ecs-service-module"
  env              = "prod"
  aspnetcore_env   = "Production"
  clusters         = ["erp-members-prod-a", "erp-members-prod-b"]
  desired_count    = 2
  target_group_arn = "${data.terraform_remote_state.clusters.erp_members_api_prod_target_group_arn}"
  image            = "${var.image}"
}

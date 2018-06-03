variable "image" {}

provider "aws" {
  region = "us-west-1"
}

terraform {
  backend "s3" {
    bucket = "halo-tfstate-primary.aws.hautelook.net"
    key    = "erp-members/members-api/qa/terraform.tfstate"
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
  env              = "qa"
  aspnetcore_env   = "Staging"
  clusters         = ["erp-members-preprod-a", "erp-members-preprod-b"]
  desired_count    = 2
  target_group_arn = "${data.terraform_remote_state.clusters.erp_members_api_qa_target_group_arn}"
  image            = "${var.image}"
}

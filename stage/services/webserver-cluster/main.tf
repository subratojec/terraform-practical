# STAGE FILES FOR WEBSERVER CLUSTER  
terraform {
  backend "s3" {
    bucket         = "terraform-up-and-running-subrato-singh-practice"
    key            = "stage/services/webserver-cluster/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_up_and_running_locks"
    encrypt        = true
  }
}


provider "aws" {
  region = "us-east-1"
}

module "webserver-cluster"{
    source = "../../../modules/services/webserver-cluster"
    cluster_name = "webservers-stage"
    db_remote_state_bucket = "terraform-up-and-running-subrato-singh-practice"
    db_remote_state_key = "stage/data-storage/mysql/terraform.tfstate"
    instance_type = "t2.micro"
    min_size = 2 
    max_size = 2
}
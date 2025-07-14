# PROD FILES FOR WEBSERVER CLUSTER  
# deploy mysql before this

terraform {
  backend "s3" {
    bucket         = "terraform-up-and-running-subrato-singh-practice"
    key            = "stage/services/webserver-cluster/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}


provider "aws" {
  region = "us-east-1"
}

module "webserver-cluster"{
    source = "../../../modules/services/webserver-cluster"
    cluster_name = "webservers-stage"
    db_remote_state_bucket = "terrafrom_up_and_running_subrato_singh_practice"
    db_remote_state_key = "prod/data-storage/mysql/terraform.tfstate" //cause of the mysql
    instance_type = "m4.large"
    min_size = 2
    max_size = 10
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 5
  recurrence = "0 9 * * *"
   autoscaling_group_name = module.webserver-cluster.aws_asg_name
}

resource "aws_autoscaling_schedule" "scale_in_the_night" {
  scheduled_action_name = "scale-in-the-night"
  min_size = 2 
  max_size = 10
  desired_capacity = 2
  recurrence = "0 17 * * *"
  autoscaling_group_name = module.webserver-cluster.aws_asg_name
}
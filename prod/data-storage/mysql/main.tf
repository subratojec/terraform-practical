provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine = "mysql"
  engine_version= "8.0.41" 
  allocated_storage = 10
  instance_class= "db.t3.micro"
  skip_final_snapshot = true
  db_name = "example_database"

  username = var.db_username
  password = var.db_password
}

terraform {
    backend "s3" {
        bucket = "terraform-up-and-running-subrato-singh-practice"
        key = "stage/data-storage/mysql/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "terraform_up_and_running_locks"
        encrypt = true
    }
}
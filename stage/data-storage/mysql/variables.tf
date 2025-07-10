variable "db_password" {
    description = "This password for the database"
    type = string 
    sensitive = true
} 

variable "db_username" {
  description = "The username for the database"
  type = string 
  sensitive = true
}       
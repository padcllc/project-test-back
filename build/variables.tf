variable "db_name" {
  description = "Name of the RDS database"
  default     = "mydatabase"  # Replace with your desired database name
}

variable "db_username" {
  description = "Username for the RDS database"
  default     = "admin"  # Replace with your desired database username
}

variable "db_password" {
  description = "Password for the RDS database"
  default     = "mysecretpassword"  # Replace with your desired database password
}

variable "aws_region" {
  description = "AWS region where resources will be created"
  default     = "us-east-1"  # Replace with your desired region
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  default     = "my-ecs-cluster"  # Replace with your desired cluster name
}

variable "ecs_task_family" {
  description = "Name of the ECS task family"
  default     = "my-task-family"  # Replace with your desired task family name
}

variable "ecs_execution_role_name" {
  description = "Name of the ECS task execution role"
  default     = "my-task-role"  # Replace with your desired role name
}

variable "ecs_container_image" {
  description = "Docker image for the ECS container"
  default     = "your-docker-image"  # Replace with your actual Docker image URL
}

variable "ecs_cpu" {
  description = "CPU units for the ECS task"
  default     = 256  # Adjust as needed
}

variable "ecs_memory" {
  description = "Memory in MiB for the ECS task"
  default     = 512  # Adjust as needed
}


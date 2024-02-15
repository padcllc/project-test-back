variable "aws_region" {
  description = "aws_region"
  type        = string
  default     = "us-east-1"
}

variable "domain_name" {
  description = "domain_name"
  type        = string
  default     = "test.padcllc.com"
}

variable "subdomain_name" {
  description = "subdomain_name"
  type        = string
  default     = "dev"
}

variable "alb_name" {
  description = "load_balancer_name"
  type        = string
  default     = "app-loadbalancer-padc"
}

variable "public_subnets_list" {
  description = "all public subnets"
  type        = list(any)
  default     = ["publicsubnet1", "publicsubnet2", ]
}
variable "private_subnets_list" {
  description = "all private subnets"
  type        = list(any)
  default     = ["privatesubnet1", "privatesubnet2", ]
}

variable "db_name" {
  description = "Name of the RDS database"
  default     = "mydatabase" # Replace with your desired database name
}

variable "db_username" {
  description = "Username for the RDS database"
  default     = "testadmin" # Replace with your desired database username
}

variable "db_password" {
  description = "Password for the RDS database"
  default     = "testpassword" # Replace with your desired database password
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  default     = "my-ecs-cluster" # Replace with your desired cluster name
}

variable "ecs_task_family" {
  description = "Name of the ECS task family"
  default     = "my-task-family" # Replace with your desired task family name
}

variable "ecs_execution_role_name" {
  description = "Name of the ECS task execution role"
  default     = "my-task-role" # Replace with your desired role name
}

variable "ecs_container_image" {
  description = "Docker image for the ECS container"
  default     = "your-docker-image" # Replace with your actual Docker image URL
}

variable "ecs_cpu" {
  description = "CPU units for the ECS task"
  default     = 256 # Adjust as needed
}

variable "ecs_memory" {
  description = "Memory in MiB for the ECS task"
  default     = 512 # Adjust as needed
}

variable "ecr_repository_name" {
  description = "Container registry variable"
  default     = "ecr-repo"
}

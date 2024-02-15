# resource "aws_db_instance" "my_database" {
#   identifier              = "mydbinstance"
#   engine                  = "postgres" # Replace with your desired database engine
#   engine_version          = "12"
#   instance_class          = "db.t2.micro" # Replace with your desired instance type
#   username                = var.db_username
#   password                = var.db_password
#   allocated_storage       = 20
#   storage_type            = "gp2"
#   publicly_accessible     = false
#   multi_az                = false
#   skip_final_snapshot     = true
#   backup_retention_period = 7
# }

resource "aws_ecr_repository" "my_ecr_repository" {
  name                 = var.ecr_repository_name # Replace with your desired repository name
  force_delete         = true
  image_tag_mutability = "MUTABLE" # Or "IMMUTABLE" depending on your needs
  # Optionally, you can specify other settings like image scanning configuration or lifecycle policies
}

resource "aws_ecs_cluster" "my_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "my_task" {
  family                   = var.ecs_task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_cpu
  memory                   = var.ecs_memory

  execution_role_arn = aws_iam_role.my_execution_role.arn

  container_definitions = <<DEFINITION
  [
    {
      "name": "my-container",
      "image": "${aws_ecr_repository.my_ecr_repository.repository_url}:latest",
      "cpu": ${var.ecs_cpu},
      "memory": ${var.ecs_memory},
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ]
    }
  ]
  DEFINITION
}

resource "aws_iam_role" "my_execution_role" {
  name = var.ecs_execution_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.my_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_service" "myservice" {
  name            = "myservice"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1
  #iam_role        = aws_iam_role.foo.arn
  #depends_on      = [aws_iam_role_policy.foo]

  # ordered_placement_strategy {
  #   type  = "binpack"
  #   field = "cpu"
  # }
  network_configuration {
    subnets          = [aws_subnet.publicsubnet1.id, aws_subnet.publicsubnet2.id]
    security_groups  = [aws_security_group.my_security_group.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.my-target-group.arn
    container_name   = "my-container"
    container_port   = 80
  }

  # placement_constraints {
  #   type       = "memberOf"
  #   expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  # }
}


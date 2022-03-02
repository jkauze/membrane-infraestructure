terraform {
  cloud {
    organization = "jkauze"

    workspaces {
      name = "Lattice_Test"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

resource "aws_ecr_repository" "backend" {
  name = var.repository_name
}

resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.cluster.name
  launch_type     = "EC2"
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.app_count
}

resource "aws_ecs_task_definition" "task" {
  family                   = var.task_family
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.task_role.arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = aws_ecr_repository.backend.repository_url
      cpu       = var.container_cpu
      memory    = var.container_mem
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
        }
      ]
    }
  ])
}
resource "aws_iam_role" "task_role" {
  name               = "ecs-task-membrane-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_policy.json

  inline_policy {
    name = "ecs-task-permissions"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["ecr:*"]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}

module "ec2_instance" {
  source = "./modules/ec2"
}
######################################################################
### ECS
######################################################################

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
      cpu       = 128
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 80
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

######################################################################
### SECURITY & IAM
######################################################################

resource "aws_security_group" "ecs_sg" {
  name = "ecs_sg"

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "ecs_agent" {
  name               = "ecs-agent"
  assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
}

resource "aws_iam_role_policy_attachment" "ecs_agent" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
resource "aws_iam_instance_profile" "ecs_agent" {
  name = "ecs-agent"
  role = aws_iam_role.ecs_agent.name
}

######################################################################
### Containter instance
######################################################################

resource "aws_instance" "membrane-ec2" {
  ami                  = "ami-0a5e7c9183d1cea27"
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
  security_groups      = [aws_security_group.ecs_sg.name]
  instance_type        = "t2.micro"
  count                = var.app_count
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=membrane-cluster >> /etc/ecs/ecs.config"
  tags = {
    Name = "membraneContainerInstance"
  }
}
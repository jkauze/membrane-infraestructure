######################################################################
### SECURITY & IAM
######################################################################

resource "aws_security_group" "ecs_sg" {
  name = "ecs_sg"

  ingress {
    from_port   = var.sg_ingress_tcp_port
    to_port     = var.sg_ingress_tcp_port
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
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
}

resource "aws_iam_role_policy_attachment" "ecs_agent" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
resource "aws_iam_instance_profile" "ecs_agent" {
  name = var.iam_role_name
  role = aws_iam_role.ecs_agent.name
}

######################################################################
### EC2 instance
######################################################################

resource "aws_instance" "membrane-ec2" {
  ami                  = var.ec2_ami
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
  security_groups      = [aws_security_group.ecs_sg.name]
  instance_type        = var.ec2_type
  count                = var.ec2_count
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config"
  tags = {
    Name = var.ec2_tag_name
  }
}
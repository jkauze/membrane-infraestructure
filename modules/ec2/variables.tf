variable "sg_ingress_tcp_port" {
  description = "AWS Segurity Group allowed ingress tcp port from anywhere"
  type        = number
  default     = 80
}

variable "iam_role_name" {
  description = "AWS IAM role name"
  type        = string
  default     = "ecs-agent"
}

variable "ec2_count" {
  description = "AWS ECS desired container instances ec2"
  type        = number
  default     = 1
}

variable "ec2_type" {
  description = "AWS EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ec2_ami" {
  description = "Communitty AMI in us-east-1 with ecs agent and docker(amzn2-ami-ecs-hvm-2.0.20220209-x86_64-ebs)"
  type        = string
  default     = "ami-0a5e7c9183d1cea27"
}

variable "ec2_tag_name" {
  description = "AWS EC2 instance tag"
  type        = string
  default     = "membraneContainerInstance"
}


variable "cluster_name" {
  description = "AWS ECS cluster name"
  type        = string
  default     = "membrane-cluster"
}


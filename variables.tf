variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "repository_name" {
  description = "AWS ECR repository name"
  type        = string
  default     = "membrane-backend"
}

variable "cluster_name" {
  description = "AWS ECS cluster name"
  type        = string
  default     = "membrane-cluster"
}

variable "service_name" {
  description = "AWS ECS service name"
  type        = string
  default     = "membrane-service"
}

variable "task_family" {
  description = "AWS ECS task family"
  type        = string
  default     = "membrane-task"
}

variable "app_count" {
  description = "AWS ECS service desired apps"
  type        = number
  default     = 1
}

variable "task_cpu" {
  description = "AWS ECS task definition cpu"
  type        = number
  default     = 1024
}

variable "task_mem" {
  description = "AWS ECS task definition memory"
  type        = number
  default     = 512
}

variable "container_cpu" {
  description = "AWS ECS container definition cpu"
  type        = number
  default     = 0
}

variable "container_mem" {
  description = "AWS ECS container definition memory"
  type        = number
  default     = 256
}

variable "container_name" {
  description = "AWS ECS container definition memory"
  type        = string
  default     = "membrane-container"
}

variable "ec2_ami" {
  description = "Communitty AMI in us-east-1 with ecs agent and docker(amzn2-ami-ecs-hvm-2.0.20220209-x86_64-ebs)"
  type        = string
  default     = "ami-0a5e7c9183d1cea27"
}

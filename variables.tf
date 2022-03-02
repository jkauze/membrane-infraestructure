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

variable "container_name" {
  description = "AWS ECS container definition memory"
  type        = string
  default     = "membrane-container"
}

variable "container_cpu" {
  description = "AWS ECS container definition cpu usage"
  type        = number
  default     = 128
}

variable "container_mem" {
  description = "AWS ECS container definition mem usage"
  type        = number
  default     = 256
}

variable "container_port" {
  description = "AWS ECS container definition port"
  type        = number
  default     = 8080
}

variable "host_port" {
  description = "AWS ECS container instance host port"
  type        = number
  default     = 80
}
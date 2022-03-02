# membrane ecs infraestructure 
Terraform ECS scrips for membrane

# Requeriments
- Change the cloud organization and workspace to your organization
- The values for `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` should be saved as environment variables on your workspace.

# Usage
>optional: setup your preference name and config in all variables.tf

initialize terraform code from membrane-infraestructure cloned repo
```sh
terraform init
```

review your plan strategy
```sh
terraform plan
```

execute your plan
```sh
terraform apply -auto-approve
```

# Documentation about infrastructure in this scripts
## ecr 
Creates an Elastic Container Registry with associated pull & push policies.
The created pull & push policies can be used as policy attachments on AWS roles.

## ecs 
Setup a basic  and ECS (type EC2) cluster with the needed IAM rights. tasks definition,
services and container definition

## ec2
Setup a basic t2.micro EC2 instace to be used as container instance in ecs-cluster with the needed IAM rights. created on default vpc

### Available main variables:
 * [`repository_name`]: String: ECR repository name
 * [`cluster_name`]: String: ECS cluster name
 * [`service_name`]: String: ECS service name
 * [`task_family`]: String: ECS task definition name
 * [`app_count`]: Number: EC2 instances number 
 * [`container_name`]: String: Container definition name
 * [`container_cpu`]: Number: Container definition cpu usage
 * [`container_mem`]: Number: Container definition mem usage
 * [`container_port`]: Number: Container definition port
 * [`host_port`]: Number: Container instance host port


### Available module ec2 variables:
 * [`sg_ingress_tcp_port`]: String: Segurity Group allowed ingress tcp port from anywhere
 * [`iam_role_name`]: String: IAM role name to allow ec2 opearte with ecs
 * [`ec2_count`]: Number: desired container instances ec2
 * [`ec2_type`]: String: ec2 instance type
 * [`ec2_ami`]: String: Special AMI with ECS agent (default is valid on us-east-1)
 * [`ec2_tag_name`]: String: ec2 tag name
 * [`cluster_name`]: String: ecs cluster name to associate the ec2 instance

## terraform cloud & GH actions
all states are store on `jkauze` organization in `Lattice_Test` workspace. this is automated with terraform automation and github actions, at the firts commit it created the infrastructure
the following commits it ask for approvals to deploy the new change

> STATE: membrane-backend Deployed http://ec2-34-238-122-145.compute-1.amazonaws.com/
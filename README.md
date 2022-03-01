# membrane ecs infraestructure 
Terraform ECS scrips for membrane

## ecr 
Creates an Elastic Container Registry with associated pull & push policies.
The created pull & push policies can be used as policy attachments on AWS roles.

## ecs 
Setup a basic  and ECS (type EC2) cluster with the needed IAM rights. tasks definition,
services and container definition

## ec2
Setup a basic t2.micro EC2 instace to be used as container instance in ecs-cluster with the needed IAM rights. created on default vpc

### Available variables:
 * [`repository_name`]: String: ECR repository name
 * [`cluster_name`]: String: ECS cluster name
 * [`service_name`]: String: ECS service name
 * [`task_family`]: String: ECS task definition name
 * [`app_count`]: Number: EC2 instances number 
 * [`container_name`]: String: Container definition name
 * [`ec2_ami`]: String: Special AMI with ECS agent (default is valid on us-east-1)
### Output
 * [`instance_ip_addr`]: String: Container instance public dns.

## terraform cloud & GH actions
all states are store on `jkauze` organization in `Lattice_Test` workspace. this is automated with terraform automation and github actions, at the firts commit it created the infrastructure
the following commits it ask for approvals to deploy the new change

> STATE: membrane-backend Deployed http://ec2-34-238-122-145.compute-1.amazonaws.com/
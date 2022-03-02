output "instance_ip_addr" {
  value = "http://${aws_instance.membrane-ec2[0].public_dns}"
}

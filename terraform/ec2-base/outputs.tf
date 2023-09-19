output "ami_info_id" {
  description = "The ID of AMI"
  value       = module.ec2-instance.ami_info_id
}

output "ami_ssh_user" {
  description = "The Default SSH User of AMI"
  value       = module.ec2-instance.ami_ssh_user
}

output "aws_instance_public_ip" {
  description = "The Public IP of Instance"
  value       = module.ec2-instance.aws_instance_public_ip
}
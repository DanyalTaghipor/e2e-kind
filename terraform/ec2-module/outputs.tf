output "ami_info_id" {
  description = "The ID of AMI"
  value       = local.ami_id
}

output "ami_ssh_user" {
  description = "The Default SSH User of AMI"
  value       = local.ssh_user
}

output "aws_instance_public_ip" {
  description = "The Public IP of Instance"
  value       = aws_instance.ansible.*.public_ip
}

provider "aws" {
  region = var.region
}


locals {
  vaild_ami_names = [for key, value in data.aws_ami.valid_amis : data.aws_ami.valid_amis[key].name]

  valid_usernames_based_on_amis = flatten([
    for ami_key, ami_data in var.ami_filters : [
      for filter_block_key, filter_block_value in ami_data.filter_block_info :
      [for vaild_name in local.vaild_ami_names : { (ami_key) = ami_data.default_user } if filter_block_value.name == "name" && contains(filter_block_value.values, vaild_name)]
    ]
  ])

  valid_usernames_by_ami = merge([for valid_username in local.valid_usernames_based_on_amis : valid_username]...)

  ami_id                 = lookup(data.aws_ami.valid_amis[var.desired_os_name], "id")
  ssh_user               = lookup(local.valid_usernames_by_ami, var.desired_os_name)
  key_name               = var.key_pair_name
  private_key_path       = "~/.aws/${var.key_pair_name}.pem"
  playbook_relative_path = "../../ansible/ansible.yaml"
}


data "aws_ami" "valid_amis" {
  for_each = var.ami_filters

  most_recent = true
  owners      = [lookup(each.value, "owner")]

  dynamic "filter" {
    for_each = lookup(each.value, "filter_block_info")

    content {
      name   = lookup(filter.value, "name")
      values = lookup(filter.value, "values")
    }

  }

}


resource "null_resource" "cluster" {
  count = var.number_of_instances

  provisioner "local-exec" {
    command = "chmod 600 ${local.private_key_path}"
  }
}


resource "aws_default_vpc" "default" {
  count = var.number_of_instances

  tags = {
    Name = "Default VPC"
  }
}


resource "aws_security_group" "ansible" {
  count = var.number_of_instances

  name   = "ansible_access"
  vpc_id = element(aws_default_vpc.default.*.id, count.index)

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "ansible" {
  count = var.number_of_instances

  ami                         = local.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [element(aws_security_group.ansible.*.id, count.index)]
  key_name                    = local.key_name

  provisioner "remote-exec" {
    inline = ["echo 'SSH Is Getting Ready...'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${element(aws_instance.ansible.*.public_ip, count.index)}, --private-key ${local.private_key_path} -u ${local.ssh_user} ${local.playbook_relative_path}"
  }
}

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 5.0 |
| null | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| aws_default_vpc.default | resource |
| aws_instance.ansible | resource |
| aws_security_group.ansible | resource |
| null_resource.cluster | resource |
| aws_ami.valid_amis | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami_filters | Different AMIs' Filters | map(object({ default_user = string owner = string filter_block_info = list(object({ name = string values = list(string) })) })) | n/a | yes |
| desired\_os\_name | Default Desired OS Name (It Should Exist As One of The ami\_filters' Keys) | `string` | n/a | yes |
| instance\_type | Default Instance Type | `string` | `"t2.micro"` | no |
| key\_pair\_name | Desired Key Pair Name | `string` | n/a | yes |
| number\_of\_instances | Number of Instances To Create | `number` | `1` | no |
| region | Default Region | `string` | `"eu-central-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| ami\_info\_id | The ID of AMI |
| ami\_ssh\_user | The Default SSH User of AMI |
| aws\_instance\_public\_ip | The Public IP of Instance |

## Note
    If you want the Ansible part to work properly when you run the Terraform code (ec2-base), use the following command in your terminal: export ANSIBLE_CONFIG=<absolute-path>/ansible.cfg.

    ⚠️ Warning: Ensure that you use the command mentioned above before running the Terraform code to avoid any issues with the Ansible setup.
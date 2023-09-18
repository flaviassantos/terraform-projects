# name this file 'terraform.tfvars'

digitalocean_token = "dop_v....example"
ssh_key = "/path/to/key/.ssh/id_rsa.pub"
ssh_key_private = "/path/to/key/.ssh/id_rsa"
user = "root"
my_ip = "62.000.241.143"

vpc_cidr_block = "10.0.0.0/16"
subnet_1_cidr_block = "10.0.0.0/24"
avail_zone = "eu-central-1a"
env_prefix = "dev"
instance_type = "t2.micro"
working_dir_ansible = "~/github/ansible-projects/run-docker-applications"
ssh_key_private = "/path/to/.ssh/id_rsa"
instance_user = "ec2-user"
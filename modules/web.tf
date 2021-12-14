variable "ssr-web-ami" {}
variable "web-web-instance" {}
variable "subnet-id" {}
variable "security-group-id" {}
variable "base-tags" {}
variable "ssr-web-name" {}
variable "key-pair" {}
variable "environment" {}
variable "encrypted" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ssr-web-instance" {

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.ssr-web-instance
  subnet_id              = var.subnet-id
  vpc_security_group_ids = [var.security-group-id]
  key_name               = var.key-pair
  iam_instance_profile   = "ssm-enabled-role"
      root_block_device {
      volume_type           = "gp2"
      volume_size           = 30
      delete_on_termination = "false"
      encrypted             = var.encrypted
    }

  tags = merge(
    var.ssr_tags,
    {
      Name = "ssrprodweb"
    },
  )


}

resource "aws_eip" "jumpbox_eip" {
  instance = aws_instance.pexip-jumpbox.id
  vpc      = true
}
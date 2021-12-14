data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

   filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon
}

resource "aws_instance" "ssr-web-instance" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.ssr-web-instance-type
  subnet_id              = aws_subnet.ssr_pub_sub_a.id
  vpc_security_group_ids = [ aws_security_group.ssr_public_web.id ]
  key_name               = var.key-pair
  # count                  = var.web-node-count
  private_ip             = "10.0.1.100"
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
      "Name": "ssrprodweb001"
    },
  )

volume_tags =  {
    "Name": "ssrprodweb001-encrypted"
  }


}

resource "aws_eip" "web-eip" {
  instance = aws_instance.ssr-web-instance.id
  vpc      = true
    tags = merge(
    var.ssr_tags,
    {
      Name = "ssrpubweb001"
    },
  )
}

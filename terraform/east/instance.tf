# data "aws_ami" "amazon_linux" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-kernel-*-x86_64-gp2"]
#   }

#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

#    filter {
#     name   = "architecture"
#     values = ["x86_64"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["137112412989"] # Amazon
# }

data "aws_ami" "thc_image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["thc-golden-image-*"]
  }

  owners = ["314027374495"] 
}



resource "aws_instance" "thc-web-instance" {
  ami                    = data.aws_ami.thc_image.id
  instance_type          = var.thc-web-instance-type
  subnet_id              = aws_subnet.shared_pub_sub_a.id
  vpc_security_group_ids = [ aws_security_group.thc_public_web.id ] 
  key_name               = var.thc-pair
  # count                  = var.web-node-count
  private_ip             = "10.0.1.160"
  iam_instance_profile   = "ssm-enabled-role"
      root_block_device {
      volume_type           = "gp2"
      volume_size           = 30
      delete_on_termination = "false"
      encrypted             = var.encrypted
    }
user_data = <<EOF
    !/bin/bash
    sudo -i
    bash /root/base-awslin2-install.sh && bash /root/thc-web.sh
    EOF
  tags = merge(
    var.thc-tags,
    {
      "Name": "thcprodweb001"
    },
  )

volume_tags =  merge(
    var.thc-tags,
    {
    "Name": "thcprodweb001-encrypted"
    },
)
}
resource "aws_eip" "thc-web-eip" {
  instance = aws_instance.thc-web-instance.id
  vpc      = true
    tags = merge(
    var.shared-tags,
    {
      Name = "thcpubweb001"
    },
  )
}

# resource "aws_instance" "ssr-web-instance" {
#   ami                    = data.aws_ami.amazon_linux.id
#   instance_type          = var.ssr-web-instance-type
#   subnet_id              = aws_subnet.shared_pub_sub_a.id
#   vpc_security_group_ids = [ aws_security_group.ssr_public_web.id ] 
#   key_name               = var.ssr-pair
#   # count                  = var.web-node-count
#   private_ip             = "10.0.1.100"
#   iam_instance_profile   = "ssm-enabled-role"
#       root_block_device {
#       volume_type           = "gp2"
#       volume_size           = 30
#       delete_on_termination = "false"
#       encrypted             = var.encrypted
#     }
# #   user_data = <<EOF
# # !/bin/bash
# # sudo -i
# # cd /tmp
# # aws s3 cp s3://314027374495-config-ssr/wp-awslin2-setup.sh .
# # chmod +x  wp-awslin2-setup.sh
# # ./wp-awslin2-setup.sh
# # exit
# # EOF

#   tags = merge(
#     var.ssr-tags,
#     {
#       "Name": "ssrprodweb001"
#     },
#   )

# volume_tags =  merge(
#     var.ssr-tags,
#     {
#     "Name": "ssrprodweb001-encrypted"
#     },
# )

# }

# resource "aws_eip" "web-eip" {
#   instance = aws_instance.ssr-web-instance.id
#   vpc      = true
#     tags = merge(
#     var.shared-tags,
#     {
#       Name = "ssrpubweb001"
#     },
#   )
# }

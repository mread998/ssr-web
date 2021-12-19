# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"] # Canonical
# }

# resource "aws_instance" "ssr-web-instance" {
#   ami                    = data.aws_ami.ubuntu.id
#   instance_type          = var.ssr-web-instance-type
#   subnet_id              = aws_subnet.ssr_pub_sub_a.id
#   vpc_security_group_ids = [ aws_security_group.ssr_public_web.id ]
#   key_name               = var.key-pair
#   iam_instance_profile   = "ssm-enabled-role"
#       root_block_device {
#       volume_type           = "gp2"
#       volume_size           = 30
#       delete_on_termination = "false"
#       encrypted             = var.encrypted
#     }

#   tags = merge(
#     var.shared_tags,
#     {
#       Name = "ssrprodweb001"
#     },
#   )


# }

# resource "aws_eip" "web-eip" {
#   instance = aws_instance.ssr-web-instance.id
#   vpc      = true
#     tags = merge(
#     var.shared_tags,
#     {
#       Name = "ssrpubweb001"
#     },
#   )
# }

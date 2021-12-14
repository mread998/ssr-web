resource "aws_vpc" "ssr-net" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = merge(
    var.ssr_tags,
    {
      Name = "ssr-vpc"
    },
  )
}

resource "aws_internet_gateway" "ssr_igw" {
   vpc_id = aws_vpc.ssr-net.id
  tags = merge(
    var.ssr_tags,
    {
      Name = "ssr-igw"
    },
  )
}


resource "aws_subnet" "ssr_pub_sub_a" {
    vpc_id = aws_vpc.ssr-net.id
    cidr_block = var.ssr_pub_sub_a

  tags = merge(
    var.ssr_tags,
    {
      Name = "ssr-public-subnet_a"
    },
  )
}

resource "aws_subnet" "ssr_pub_sub_b" {
    vpc_id = aws_vpc.ssr-net.id
    cidr_block = var.ssr_pub_sub_b

  tags = merge(
    var.ssr_tags,
    {
      Name = "ssr-public-subnet_b"
    },
  )
}


# resource "aws_subnet" "ssr_sub_pri" {
#     vpc_id = aws_vpc.ssr-net.id
#     cidr_block = var.ssr_pri_sub_a

#   tags = merge(
#     var.ssr_tags,
#     {
#       Name = "ssr-private-subnet_a"
#     },
#   )
# }

resource "aws_route_table" "ssr_public_rt" {
    vpc_id = aws_vpc.ssr-net.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ssr_igw.id
    }

  tags = merge(
    var.ssr_tags,
    {
      Name = "ssr-public-rt"
    },
  )
}

# resource "aws_route_table" "ssr_private_rt" {
#     vpc_id = aws_vpc.ssr-net.id

#     route{
#         cidr_block = var.ssr_pri_sub_a
#     }

#   tags = merge(
#     var.ssr_tags,
#     {
#       Name = "ssr-public-rt"
#     },
#   )  
# }

resource "aws_route_table_association" "ssr_rta_pub_a" {
    subnet_id = aws_subnet.ssr_pub_sub_a.id
    route_table_id = aws_route_table.ssr_public_rt.id
}

resource "aws_route_table_association" "ssr_rta_pub_b" {
    subnet_id = aws_subnet.ssr_pub_sub_b.id
    route_table_id = aws_route_table.ssr_public_rt.id
}

# resource "aws_route_table_association" "ssr_rta_pri" {
#     subnet_id = aws_subnet.ssr_sub_pri.id
#     route_table_id = aws_route_table.ssr_pri_rot.id
  
# }

resource "aws_vpc" "shared-net" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = merge(
    var.shared-tags,
    {
      Name = "shared-vpc"
    },
  )
}

resource "aws_internet_gateway" "shared_igw" {
   vpc_id = aws_vpc.shared-net.id
  tags = merge(
    var.shared-tags,
    {
      Name = "shared--igw"
    },
  )
}


resource "aws_subnet" "shared_pub_sub_a" {
    vpc_id = aws_vpc.shared-net.id
    cidr_block = var.shared_pub_sub_a

  tags = merge(
    var.shared-tags,
    {
      Name = "shared-public-subnet_a"
    },
  )
}

resource "aws_subnet" "shared_pub_sub_b" {
    vpc_id = aws_vpc.shared-net.id
    cidr_block = var.shared_pub_sub_b

  tags = merge(
    var.shared-tags,
    {
      Name = "shared-public-subnet_b"
    },
  )
}


# resource "aws_subnet" "shared-_sub_pri" {
#     vpc_id = aws_vpc.shared-net.id
#     cidr_block = var.shared-_pri_sub_a

#   tags = merge(
#     var.shared-tags,
#     {
#       Name = "shared--private-subnet_a"
#     },
#   )
# }

resource "aws_route_table" "shared_public_rt" {
    vpc_id = aws_vpc.shared-net.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.shared_igw.id
    }

  tags = merge(
    var.shared-tags,
    {
      Name = "shared-public-rt"
    },
  )
}

# resource "aws_route_table" "shared-_private_rt" {
#     vpc_id = aws_vpc.shared-net.id

#     route{
#         cidr_block = var.shared-_pri_sub_a
#     }

#   tags = merge(
#     var.shared-tags,
#     {
#       Name = "shared--public-rt"
#     },
#   )  
# }

resource "aws_route_table_association" "shared_rta_pub_a" {
    subnet_id = aws_subnet.shared_pub_sub_a.id
    route_table_id = aws_route_table.shared_public_rt.id
}

resource "aws_route_table_association" "shared_rta_pub_b" {
    subnet_id = aws_subnet.shared_pub_sub_b.id
    route_table_id = aws_route_table.shared_public_rt.id
}

# resource "aws_route_table_association" "shared-_rta_pri" {
#     subnet_id = aws_subnet.shared-_sub_pri.id
#     route_table_id = aws_route_table.shared-_pri_rot.id
  
# }

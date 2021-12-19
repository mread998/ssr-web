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
  subnet_id              = aws_subnet.shared_pub_sub_a.id
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
#   user_data = <<EOF
# !/bin/bash
#   # This is a boot strap script to install wordpress

# # install ssm agent not needed amazon linux
# # cd /tmp
# # sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
# # sudo systemctl enable amazon-ssm-agent
# # sudo systemctl start amazon-ssm-agent

# # update amazon linux 2
# sudo yum update -y

# # Package install
# amazon-linux-extras install nginx1 php8.0 epel -y
# yum install mariadb certbot python2-certbot-nginx php-{pear,cgi,curl,mbstring,gd,gettext,bcmath,xml,intl,zip} -y

# # php fpm
# # update config file 
# sed -i -e 's/user = apache/user = nginx/g' /etc/php-fpm.d/www.conf
# sed -i -e 's/group = apache/group = nginx/g' /etc/php-fpm.d/www.conf
# sed -i -e 's/pm = dynamic/pm = ondemand/g' /etc/php-fpm.d/www.conf

# # enable and start php fpm
# systemctl enable php-fpm
# systemctl start php-fpm

# # get config file
# cd /etc/nginx/conf.d
# aws s3 cp s3://314027374495-config-ssr/ssr.conf .


# ## to do ##
# # start nginx
# systemctl enable nginx
# systemctl start nginx

# # install let's encrypt
# # Installed up top
# # yum install certbot python2-certbot-apache -y

# # more to figure out
# # configure let's encrypt with out input

# certbot --nginx --non-interactive --agree-tos --domains sixstringrevival.com --domains www.sixstringrevival.com --email marcread@gmail.com

# # add dmain to exsiting certificate with out renowal
# # certbot certonly -d sixstringrevival.com -d www.sixstringrevival.com

# # create directory for web pages
# mkdir -p /var/www/html


# # Install wordpress
# cd /tmp
# mkdir /var/www/html/sixstringrevival.com
# wget https://wordpress.org/latest.tar.gz
# # extracts contents into /var/www/html and removes wordpress directory level
# tar -xzvf latest.tar.gz -C /var/www/html/sixstringrevival.com --strip-components=1
# # get config file
# cd /var/www/html/sixstringrevival.com
# aws s3 cp s3://314027374495-config-ssr/wp-config.php .

# # update permissions
# chown nginx.nginx -R /var/www/html/sixstringrevival.com

# EOF

  tags = merge(
    var.shared-tags,
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
    var.shared-tags,
    {
      Name = "ssrpubweb001"
    },
  )
}

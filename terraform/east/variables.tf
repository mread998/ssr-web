variable "ssr_tags" {
    type = map(string)
    default = { "Enviroment": "Prod",  "Project": "six string revival", "Owner": "TBA", "Url": "http://www.sixstringrevival.com" } 
}

variable "name" {
    type = string
    default = "ssw-web"
}

variable "web-node-count" {
    type = string
    default = "1"
  
}

variable "vpc-name" {
    type = string
    default = "ssw-web"
}

# variable "ssr-web-ami" {
#     type = string
#     default = "xxxx"  
# }

variable "ssr-web-instance-type" {
    type = string
    default = "t2.micro"  
}

variable "key-pair" {
    type = string
    default = "ssr-key"  
}

variable "encrypted" {
    type = string
    default = "true"  
}

variable "ssr_pub_sub_a" {
    type = string
    default = "10.0.1.0/24"  
}

variable "ssr_pub_sub_b" {
    type = string
    default = "10.0.3.0/24"  
}

variable "ssr_pub_sub_c" {
    type = string
    default = "10.0.5.0/24"  
}

variable "ssr_pri_sub_a" {
    type = string
    default = "10.0.2.0/24"  

}

variable "ssr_pri_sub_b" {
    type = string
    default = "10.0.4.0/24"  
}

variable "ssr_pri_sub_c" {
    type = string
    default = "10.0.6.0/24"  
}


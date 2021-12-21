variable "shared-tags" {
    type = map(string)
    default = { "Enviroment": "Prod",  "Project": "TBA", "Owner": "TBA", "Url": "TBA" } 
}

variable "ssr-tags" {
    type = map(string)
    default = { "Enviroment": "Prod",  "Project": "ssr", "Owner": "TBA", "Url": "https://www.sixstringrevival.com/" } 
}

variable "thc-tags" {
    type = map(string)
    default = { "Enviroment": "Prod",  "Project": "thc", "Owner": "TBA", "Url": "https://www.thunderchrome.com/" } 
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

variable "thc-web-instance-type" {
    type = string
    default = "t2.micro"  
}

variable "ssr-pair" {
    type = string
    default = "ssr-key"  
}

variable "thc-pair" {
    type = string
    default = "thc-key"  
}

variable "encrypted" {
    type = string
    default = "true"  
}

variable "shared_pub_sub_a" {
    type = string
    default = "10.0.1.0/24"  
}

variable "shared_pub_sub_b" {
    type = string
    default = "10.0.3.0/24"  
}

variable "shared_pub_sub_c" {
    type = string
    default = "10.0.5.0/24"  
}

variable "shared_pri_sub_a" {
    type = string
    default = "10.0.2.0/24"  

}

variable "shared_pri_sub_b" {
    type = string
    default = "10.0.4.0/24"  
}

variable "shared_pri_sub_c" {
    type = string
    default = "10.0.6.0/24"  
}


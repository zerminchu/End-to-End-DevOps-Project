variable "instance_ami" {
  default = "ami-02c7683e4ca3ebf58"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "ec2_name" {
    default = ["Jenkins","Prometheus and Grafana"]
}

variable "vpc_id" {
 default = "vpc-03ef2d5b99ca1aedc" 
}

variable "subnet_id" { 
    default = ["subnet-0bf6d526c3921623f", "subnet-06810573ce87e4c90" ]
}

variable "ec2_ingress_rule" {
    type = map(object({
        port = number
        protocol = string
        cidr_block = list(string)
        description = string
    }))
    default = {
        "ssh" = {
            port = 22
            protocol = "tcp"
            cidr_block = ["10.0.0.0/24"]
            description = "SSH access"
        }
        "jenkins" = {
            port = 8080
            protocol = "tcp"
            cidr_block = ["10.0.0.0/24"]
            description = "Jenkins web interface"
        }
        "prometheus" = {
            port = 9090
            protocol = "tcp"
            cidr_block = ["10.0.0.0/24"]
            description = "Prometheus web interface"
        }
        "grafana" = {
            port = 3000
            protocol = "tcp"
            cidr_block = ["10.0.0.0/24"]
            description = "Grafana web interface"
        }
        "http" = {
            port = 80
            protocol = "tcp"
            cidr_block = ["10.0.0.0/24"]
            description = "HTTP access"
        }
        "https" = {
            port = 443
            protocol = "tcp"
            cidr_block = ["10.0.0.0/24"]
            description = "HTTPS access"
        }
    }
}

# variable "key" {
# }

variable "ec2_sg"{
    default = {
        Name ="sg"
    }
}

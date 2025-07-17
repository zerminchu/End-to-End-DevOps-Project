variable "region" {
  default = "ap-southeast-1"
}

variable "eks_name" {
    default = "testing_k8s"
}

variable "subnet_id" { 
    default = ["subnet-0bf6d526c3921623f", "subnet-06810573ce87e4c90" ]
}


variable "vpc_id" {
default= "vpc-03ef2d5b99ca1aedc" 
}

variable "node_name" {
    default = "test-node-group"
  
}

variable "sg" {
  default = {
    Name = "EKS_Terraform_SG"
  }
}

variable "node_sg" {
  default = {
    Name = "EKS_node_grp_Terraform_SG"
  }
}

variable "eks_ingress_rule" {
  type = map(object({
    port         = number
    protocol     = string
    cidr_block   = list(string)
    description  = string
  }))
  default = {
    "https" = {
      port = 443
      protocol = "tcp"
      cidr_block = ["10.0.0.0/24"]
      description = "HTTPS access for EKS API server"
    }
    "kubectl" = {
      port = 6443
      protocol = "tcp"
      cidr_block = ["10.0.0.0/24"]
      description = "Kubernetes API server"
    }
    "node_port_range" = {
      port = 30000
      protocol = "tcp"
      cidr_block = ["10.0.0.0/24"]
      description = "NodePort service range (30000-32767)"
    }
    "ingress_controller" = {
      port = 80
      protocol = "tcp"
      cidr_block = ["10.0.0.0/24"]
      description = "HTTP traffic for ingress controller"
    }
  }
}

variable "eks_cluster_policies" {
  default = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy",
    "arn:aws:iam::aws:policy/AmazonEKSComputePolicy",
    "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy"
  ]
}

variable "eks_node_policies" {
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
    "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy",
    "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  ]
}
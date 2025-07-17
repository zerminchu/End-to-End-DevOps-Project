resource "aws_iam_role" "cluster_role" {
  name = "Terraform_EKS_Cluster_Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "Terraform_EKS_Cluster_Role"
    Purpose = "EKS-Cluster-Service-Role"
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
    for_each = toset(var.eks_cluster_policies)
    role = aws_iam_role.cluster_role.name
    policy_arn = each.value
}

resource "aws_iam_role" "node_role" {
  name = "Terraform_EKS_Node_Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "Terraform_EKS_Node_Role"
    "eks:eks-cluster-name" = var.eks_name
  }
}

resource "aws_iam_role_policy_attachment" "eks_node_policy" {
    for_each = toset(var.eks_node_policies)
    role = aws_iam_role.node_role.name
    policy_arn = each.value
}

resource "aws_iam_role" "vpc_cni_pod_identity_role" {
  name = "Terraform_AmazonEKSPodIdentityAmazonVPCCNIRole"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "pods.eks.amazonaws.com"
            },
            "Action": [
                "sts:AssumeRole",
                "sts:TagSession"
            ]
        }
    ]
  })

  tags = {
    Name = "Terraform_VPC_CNI_Pod_Identity_Role"
    Purpose = "EKS-VPC-CNI-Pod-Identity"
  }
}

resource "aws_iam_role_policy_attachment" "eks_vpc_cni_policy" {
  role       = aws_iam_role.vpc_cni_pod_identity_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}



resource "aws_security_group" "dd_cluster" {
  name        = "terraform-eks-dd-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = data.terraform_remote_state.vpc_dev.outputs.vpc_dev

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-cluster"
  }
}

resource "aws_security_group_rule" "dd_cluster_ingress_workstation_https" {
  cidr_blocks       = var.cidr_block
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.dd_cluster.id
  to_port           = 443
  type              = "ingress"
}

# EKS nodes
resource "aws_security_group" "eks_node" {
  name        = "terraform-eks-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = data.terraform_remote_state.vpc_dev.outputs.vpc_dev

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-node"
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
  }
}

resource "aws_security_group_rule" "eks_node_ingress_self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_node.id
  source_security_group_id = aws_security_group.eks_node.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks_node_ingress_cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_node.id
  source_security_group_id = aws_security_group.dd_cluster.id
  to_port                  = 65535
  type                     = "ingress"
}

# Access from nodes to EKS master cluster
resource "aws_security_group_rule" "dd_cluster_ingress_node_https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.dd_cluster.id
  source_security_group_id = aws_security_group.eks_node.id
  to_port                  = 443
  type                     = "ingress"
}

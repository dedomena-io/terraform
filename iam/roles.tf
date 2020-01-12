# EKS role dd-eks-dev
resource "aws_iam_role" "dd_dev_cluster" {
  name = "dd-dev-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "dd_dev_cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.dd_dev_cluster.name
}

resource "aws_iam_role_policy_attachment" "dd_dev_cluster_AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.dd_dev_cluster.name
}

# EKS role dd-dev-node
resource "aws_iam_role" "dd_dev_node" {
  name = "dd-dev-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "dd_dev_node_AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.dd_dev_node.name
}

resource "aws_iam_role_policy_attachment" "dd_dev_node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.dd_dev_node.name
}

resource "aws_iam_role_policy_attachment" "dd_dev_node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.dd_dev_node.name
}

resource "aws_iam_instance_profile" "dd_dev_node" {
  name       = "dd-dev-node"
  role       = aws_iam_role.dd_dev_node.name
}

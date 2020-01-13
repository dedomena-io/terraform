resource "aws_eks_cluster" "dd_dev" {
  name            = var.cluster-name
  role_arn        = data.terraform_remote_state.iam.outputs.dd_dev_eks

  vpc_config {
    security_group_ids = [
      aws_security_group.dd_cluster.id
    ]
    subnet_ids         = [
      data.terraform_remote_state.vpc_dev.outputs.aws_subnet_private_a,
      data.terraform_remote_state.vpc_dev.outputs.aws_subnet_private_b,
      data.terraform_remote_state.vpc_dev.outputs.aws_subnet_private_c
    ]
  }

}

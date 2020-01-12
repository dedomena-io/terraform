output "dd_dev_eks" { value = "${aws_iam_role.dd_dev_cluster.arn}" }
output "dd_dev_policy" { value = "${aws_iam_role_policy_attachment.dd_dev_cluster_AmazonEKSClusterPolicy.id}" }
output "dd_dev_service" { value = "${aws_iam_role_policy_attachment.dd_dev_cluster_AmazonEKSServicePolicy.id}" }

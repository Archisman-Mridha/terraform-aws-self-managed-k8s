/* resource "null_resource" "fetch_kubeconfig" {
  provisioner "local-exec" {
    command = <<-EOC

      chmod 400 ${path.module}/outputs/private-key.pem

      scp -i ${path.module}/outputs/private-key.pem \
        ubuntu@${aws_elb.elb.dns_name}:.kube/config \
        ${path.module}/outputs/kubeconfig.yaml

    EOC
  }

  depends_on = [null_resource.bootstrap_initial_master_node]
} */
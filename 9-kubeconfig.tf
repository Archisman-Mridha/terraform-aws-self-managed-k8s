resource "null_resource" "fetch_kubeconfig" {
  provisioner "local-exec" {
    command = <<-EOC

      chmod 400 ${path.module}/outputs/private-key.pem

      scp -i ${path.module}/outputs/private-key.pem \
        ubuntu@${aws_instance.master_node.public_ip}:.kube/config \
        ${path.module}/outputs/kubeconfig.yaml

    EOC
  }

  depends_on = [aws_instance.master_node]
}
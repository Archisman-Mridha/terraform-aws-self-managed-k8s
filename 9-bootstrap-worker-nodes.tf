/* resource "null_resource" "fetch_kubeadm_join_script" {
  provisioner "local-exec" {
    command = <<-EOC

      chmod 400 ${path.module}/outputs/private-key.pem

      scp -i ${path.module}/outputs/private-key.pem \
        ubuntu@${aws_instance.master_nodes[0].public_ip}:kubeadm-join.sh \
        ${path.module}/outputs/kubeadm-join.sh

      echo -n "sudo " | cat - ${path.module}/outputs/kubeadm-join.sh > temp && mv temp ${path.module}/outputs/kubeadm-join.sh

    EOC
  }

  depends_on = [null_resource.bootstrap_initial_master_node]
}

resource "null_resource" "bootstrap_worker_nodes" {
  count = length(var.aws_zones)

  provisioner "remote-exec" {
    connection {
      host = aws_instance.worker_nodes[count.index].public_ip

      user = "ubuntu"
      private_key = tls_private_key.private_key.private_key_pem
    }

    when = create
    on_failure = fail

    scripts = [
      "${path.module}/scripts/kubeadm-installer.sh",
      "${path.module}/outputs/kubeadm-join.sh"
    ]
  }
} */
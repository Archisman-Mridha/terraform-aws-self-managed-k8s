resource "null_resource" "bootstrap_initial_master_node" {
  provisioner "remote-exec" {
    connection {
      host = aws_instance.master_nodes[0].public_ip

      user = "ubuntu"
      private_key = tls_private_key.private_key.private_key_pem
    }

    when = create
    on_failure = fail

    inline = [
      file("${path.module}/scripts/kubeadm-installer.sh"),
      templatefile(
        "${path.module}/scripts/initial-master-node.bootstrapper.sh",
        {
          KUBE_API_PUBLIC_ENDPOINT: aws_lb.lb.dns_name
        }
      )
    ]
  }

  depends_on = [ aws_lb_target_group_attachment.lb_initial_master_node_attachment ]
}

/* resource "null_resource" "bootstrap_remaining_master_nodes" {
  count = length(var.aws_zones) - 1

  provisioner "remote-exec" {
    connection {
      host = aws_instance.master_nodes[count.index + 1].public_ip

      user = "ubuntu"
      private_key = tls_private_key.private_key.private_key_pem
    }

    when = create
    on_failure = fail

    inline = [
      file("${path.module}/scripts/kubeadm-installer.sh"),
      templatefile(
        "${path.module}/scripts/master-node.bootstrapper.sh",
        {
          KUBE_API_PUBLIC_ENDPOINT: aws_elb.elb.dns_name
        }
      )
    ]
  }

  depends_on = [
    null_resource.bootstrap_initial_master_node
  ]
}

resource "aws_lb_target_group_attachment" "lb_remaining_master_nodes_attachments" {
  count = length(var.aws_zones) - 1

  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id = aws_instance.master_nodes[count.index + 1].private_ip
} */
# Self Managed k8s in AWS

> This Terraform module creates a self-managed Kubernetes cluster in AWS

It uses **Kubeadm** behind the scenes, to bootstrap the Kubernetes cluster. You can find the **kubeconfig.yaml** file at *outputs/kubeconfig.yaml*.

## Limitations

Currently, this module is not flexible at all. Here are the limitations -

- Only a single master node is created.
- All nodes are provisioned in public subnets.
- Ubuntu is the only supported OS.


## Roadmap

- [ ] Support high availability mode (multiple master nodes)
- [ ] Write E2E tests using Terratest.
- [ ] Provision all the nodes in private subnets.

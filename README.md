# Self Managed k8s in AWS

> This Terraform module creates a self-managed Kubernetes cluster in AWS. Don't use this for production purposes!

It takes a list of availability zones (AZs) from the user and creates a public subnet in each AZ. A master node is bootstrapped in the first subnet. Then, a worker node is bootstrapped in each of the public subnets.

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

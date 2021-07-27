# Hetzner servers setup

# Usage
Create file named `variables.tf` and redefine all the necessary avriables.
The mandatory variables are:
- hcloud_token: your API key for hetzner
- scope: a prefix used in name of every resource. I.e. if scope = "foobar", then servers will have name such as foobar_master-1
- hcloud_ssh_keys: list of ssh key names

Example:
```hcl
hcloud_token = "X-SECRET-KEY"
scope = "watman"
hcloud_ssh_keys = ["Watman Root Key"]
```

You can redeclare any variable from variables.tf, such as number nodes, types of nodes and so on.

To apply the configuration, run `terraform apply`. To destroy, run `terraform destroy`
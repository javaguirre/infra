# INFRASTRUCTURE WEALIZE

Welcome welcome! This is the AWS (and others maybe) infrastructure repository for Wealize.

## Installation and Configuration

First of all, [Install Terraform!](https://learn.hashicorp.com/terraform/getting-started/install.html)

Then you need to go to the INFRA vault in 1 Password and get the Terraform AWS credentials.

Then, in the terminal you're gonna use Terraform:

```
export AWS_ACCESS_KEY_ID=<KEY>
export AWS_SECRET_ACCESS_KEY=<SECRET_KEY>
```

After that you need to go to `cd terraform` and copy the Secure Note (infra.tfvars) in 1Password INFRA vault into a `infra.tfvars file inside this `terraform` folder.

Then you start the magic!

```bash
terraform init -var-file infra.tfvars
terraform plan -var-file infra.tfvars
```

Init installs the AWS provider plugin for Terraform in your machine.

Plan shows you what Terraform is gonna do in your AWS, it does nothing for now but it's interesting to see what's going to change.

Once we're happy with the changes:

```bash
terraform apply -var-file infra.tfvars
```

This option creates or updates whatever change you wrote and you see in the `plan` action.

Happy Terraforming!

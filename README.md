# terraform-aws-ecs-cluster

Terraform module to provision an [`ECS Cluster`](https://aws.amazon.com/en/ecs/).

Supports [Amazon ECS Fargate](https://docs.aws.amazon.com/AmazonECS/latest/userguide/fargate-capacity-providers.html) capacity provider.

## Usage

### Basic

<details open>
  <summary>Terragrunt</summary>

```hcl
terraform {
  source = "git::https://github.com/developertown/terraform-aws-route53.git?ref=vVERSION"
}

inputs = {
  region   = "us-east-1"
  dns_name = "somedomain.com"
}
```

</details>

<details>
  <summary>Terraform</summary>

```hcl
module "apex_zone" {
  source  = "github.com/developertown/terraform-aws-route53.git"
  version = "VERSION"

  region   = "us-east-1"
  dns_name = "somedomain.com"
}
```

</details>

## Providers

| Name            | Version     |
| --------------- | ----------- |
| `hashicorp/aws` | `~> 4.36.1` |

## Inputs

| Input              | Description                                                       | Default | Required |
| ------------------ | ----------------------------------------------------------------- | ------- | -------- |
| region             | AWS Region to create resources in                                 | N/A     | Yes      |
| tags               | A set of key/value label pairs to assign to this to the resources | `{}`    | No       |
| role_arn           | The AWS assume role                                               | `""`    | No       |
| dns_name           | The DNS zone to create                                            | N/A     | Yes      |
| dns_ttl            | The TTL for Route53 NS Records                                    | `60`    | No       |
| parent_dns_zone_id | The Route53 Zone to create an NS Record                           | `""`    | No       |
| parent_role_arn    | The AWS assume role                                               | `""`    | No       |

## Outputs

| Output       | Description                             |
| ------------ | --------------------------------------- |
| domain_name  | The domain name created in the dns zone |
| name_servers | The name servers for the dns zone       |
| zone_id      | The Route53 Zone ID                     |

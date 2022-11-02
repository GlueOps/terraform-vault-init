module "rerun" {
  source = "git::https://github.com/GlueOps/terraform-toggle-rerun-for-tfc-operator.git?ref=v0.1.0"
}

variable "VAULT_ADDR" {
  type        = string
  description = "The url of the vault server Example: https://vault.us-production.glueops.rocks"
}

terraform {
  required_providers {
    vaultoperator = {
      source  = "rickardgranberg/vaultoperator"
      version = "0.1.6"
    }
    tfe = {
      version = "~> 0.38.0"
    }
  }
}

provider "vaultoperator" {
  vault_addr = var.VAULT_ADDR
}

resource "vaultoperator_init" "default" {
  recovery_shares    = 5
  recovery_threshold = 3
}

provider "tfe" {
  token = "i1BfvCctbwCoeQ.atlasv1.NQ8Zdc7OcKBVMWjzC2RijoIvnqpUluYJDIIgrsDSWaSfiLLLPO3LD4VWaVF1qbQ7FnM" #This token is entirely restricted to the throwaway tfc org. Although obviously not best practice commiting a secret like this into a public repo
}

resource "tfe_workspace" "test" {
  name         = "my-workspace-name"
  organization = "dev-aws-venkata"
  tag_names    = ["test", "app"]
}
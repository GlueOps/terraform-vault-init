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
  }
}

provider "vaultoperator" {
  vault_addr = var.VAULT_ADDR
}

resource "vaultoperator_init" "default" {
  recovery_shares    = 5
  recovery_threshold = 3
}

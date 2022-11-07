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
  
  data "tfe_organizations" "org" {}
  
resource "tfe_variable_set" "tf_core" {
  name         = "Global Varset"
  description  = "Variable set applied to all workspaces."
  global       = true
  organization = data.tfe_organizations.org.names[0]
}
  
  
resource "tfe_variable" "test-a" {
  key             = "VAULT_ADDR"
  value           = var.VAULT_ADDR
  category        = "env"
  sensitive = false
  description     = "Vault Server Address"
  variable_set_id = tfe_variable_set.tf_core.id
}

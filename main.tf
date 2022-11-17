module "rerun" {
  source = "git::https://github.com/GlueOps/terraform-toggle-rerun-for-tfc-operator.git?ref=v0.1.0"
}

terraform {
  required_providers {
    vaultoperator = {
      source  = "rickardgranberg/vaultoperator"
      version = "0.1.6"
    }
  }
}
  
  
# resource "time_sleep" "wait" {
#   depends_on = [time_sleep.wait]

#   create_duration = "360s"
# }

provider "vaultoperator" {}

resource "vaultoperator_init" "default" {
  recovery_shares    = 5
  recovery_threshold = 3

#   depends_on = [
#     time_sleep.wait
#   ]
}
  
  data "tfe_organizations" "org" {}
  
resource "tfe_variable_set" "tf_core" {
  name         = "Global Varset"
  description  = "Variable set applied to all workspaces."
  global       = true
  organization = data.tfe_organizations.org.names[0]
}
  
  
 resource "tfe_variable" "VAULT_TOKEN" {
  key             = "VAULT_TOKEN"
  value           = vaultoperator_init.default.root_token
  category        = "env"
  sensitive = true
  description     = "Vault Root Token"
  variable_set_id = tfe_variable_set.tf_core.id
}

# terraform-vault-init


This vault-init module is use to initialize the vault cluster and will provide the root token and/or recovery tokens. If the vault cluster has a cloud KMS configured then the cluster should be automatically unsealed after the initalization. All tokens will be stored inside the terraform state so please be sure to keep the statefile some place secure and encrypted.

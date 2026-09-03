# Azure Infrastructure Architecture

```text
                         +---------------------------+
                         |        Azure Subscription |
                         +-------------+-------------+
                                       |
                              +--------v--------+
                              | Resource Group  |
                              |    (Dev)        |
                              +--------+--------+
                                       |
                   +-------------------+-------------------+
                   |                                       |
             +-----v------+                           +----v-----+
             |   VNet     |                           | Key Vault |
             | 10.0.0.0/16|                           | Secrets   |
             +-----+------+                           +----------+
                   |
         +---------+---------+
         |                   |
   +-----v------+       +----v----------------+
   | VM Subnet  |       | AzureBastionSubnet  |
   | VM-1 / VM-2|       | Bastion + Public IP |
   +-----+------+       +---------------------+
         |
   +-----+------------------+
   |                        |
+--v-----+              +---v----+
| Linux  |              | Linux  |
| VM-1   |              | VM-2   |
+--------+              +--------+

Additional Azure services in the environment:

  Azure SQL Server + Database
  Storage Account
  Azure Container Registry (ACR)
  Azure Kubernetes Service (AKS)
```

The Terraform code is organized around reusable modules with environment-specific inputs under `Environment/Dev` and a separate `Environment/Prod` structure. Secrets are intended to be injected securely rather than committed to source control.

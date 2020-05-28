# ansible-mco-vault

Since version 1.4 of Hashicorp Vault, Backend Raft for Cluster is available and by the way, Vault become a statefull workload.

The goal of this project is to facility maintain in operational condition a Vault Cluster with Ansible while there is no autopilot on Vault Raft Backend (unlike in Consul).


## Prerequisite

For now, we only work with an instance which already met all OS, package dependancies with a first vault install like UserData, shell script, ansible or else. 
The most import part is to have a correct inventory, for a replacement like destroy & replace, or even a fresh new cluster.
Inventory need to have all the vault instance of the Raft cluster with their private IP and to know which will be the master node.

## Ansible Role

This Ansible Role will for each host :

- Download Vault, install or replace it
- Replace HCL configuration file with templating
- Reload Vault service with low perturbation as possible

## Next steps

You will need to handle by yourself backup and restore.

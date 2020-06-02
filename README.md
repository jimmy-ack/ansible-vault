=======
ansible-lss-vault
=========

Since version 1.4 of Hashicorp Vault, Backend Raft for Cluster is available and by the way, Vault become a statefull workload.

The goal of this project is to facility maintain in operational condition a Vault Cluster with Ansible while there is no autopilot on Vault Raft Backend (unlike in Consul).

This Ansible Role will for each host :

- Download Vault, install or replace it
- Replace HCL configuration file with templating
- Reload Vault service with low perturbation as possible

## Prerequisite

For now, we only work with an instance which already met all OS, package dependancies with a first vault install like UserData, shell script, ansible or else. 
The most import part is to have a correct inventory, for a replacement like destroy & replace, or even a fresh new cluster.
Inventory need to have all the vault instance of the Raft cluster with their private IP and to know which will be the master node.

## Role Usage

You will need to handle by yourself backup and restore.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).

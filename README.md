ansible-lss-vault-install
=========

## Goal
This role deploys one or many vault servers:
- `1` vault_leader
- `n` vault_followers

It uses the `raft` storage backend (available since [Hashicorp Vault](https://www.vaultproject.io/) v1.4.0)

## Usage
| Files                            | Purpose                                                  |
| -------------------------------- | -------------------------------------------------------- |
| `vault-install-requirements.yml` | Download and install this role                           |
| `vault-install-inventory.yml`    | Defines vault hosts (`vault_leader` + `vault_followers`) |
| `vault-install-playbook.yml`     | Deploys the role base on your `inventory`                |
---------

### **Install the role**
`vault-install-requirements.yml`
```yml
- src: https://github.com/jimmy-ack/ansible-lss-vault-install
  name: ansible-lss-vault-install
  version: develop
  scm: git
```

```sh
ansible-galaxy install -r vault-install-requirements.yml -f
```

### **Setup the inventory**
`vault-install-inventory.yml`
```yml
[vault_leader]
vault-0.<your_dns>

[vault_followers]
vault-1.<your_dns>
vault-2.<your_dns>

[all:vars]
ansible_user=<your_user>
```

### **Deploy the role** (using its default behavior)
`vault-install-playbook.yml`
```yml
- name: Install Vault
  hosts: vault_leader:vault_followers
  become: true
  become_user: root
  gather_facts: true
  any_errors_fatal: true
    
  tasks:
    - include_role:
        name: ansible-lss-vault-install
```

```sh
ansible-playbook vault-install-playbook.yml -i vault-install-inventory.yml -v
```

### **Role vars**
| Variable                   | Default             | Details
| -------------------------- | ------------------- | -------
| `vault_version`            | `1.5.3`             |
| `env_dns_suffix`           | `vault.example.com` | Used in the role to connect between vault hosts
| `vault_address`            | `<host_ip>`         | IP addr from which Vault will be accessible from<br>Eg: `0.0.0.0`
| `vault_auto_unseal`        | `false`             | Enables/Disables Vault auto-unseal feature
| `etc_host`                 | `false`             | Add /etc/hosts vault entries if no dns is available
| `init_unseal_join`         | `false`             | Vault automatic init + unseal (shamir & cloud-kms compatible) + join<br>Use only for dev. **DO NOT use in production**
| `vault_tls_cert_key_store` | n/a                 | Path where to install a private PKI<br>Eg centos: `vault_tls_cert_key_store: /etc/pki/ca-trust/source/anchors`
| -------------------------- | ------------------- | -------
| **`vault_flavor`**         | `oss`               | Can be `oss` / `ent` / `prem` / `prem.hsm`
| `vault_s3_access_key`      | n/a                 | Required if `vault_flavor: prem` or `prem.hsm` to authenticate upon s3
| `vault_s3_secret_key`      | n/a                 | Required if `vault_flavor: prem` or `prem.hsm` to authenticate upon s3
| -------------------------- | ------------------- | -------
| **`vault_tls_disable`**    | `"true"`            |
| `vault_tls_src_files`      | n/a                 | Required if `vault_tls_disable: "false"`<br>Relative path of `vault-install-playbook.yml` where to look for certs
| -------------------------- | ------------------- | -------
| **`vault_awskms`**         | `false`             | Enables/Disables auto-unseal using aws-kms
| `vault_awskms_key_id`      | n/a                 | Required if `vault_awskms: true`<br>
| `vault_awskms_region`      | `us-east-1`         |
---------

Once the role is deployed:
1. [Master] `vault operator init -recovery-shares=1 -recovery-threshold=1 > key`
2. [Followers] `vault operator raft join https://vault-0.vault.lzlab.cloud:8200`

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

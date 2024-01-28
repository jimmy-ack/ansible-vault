# Acknowledge ansible-vault role

As an Hashicorp partner we are regurlarly deploying vault for our customers.
The purpose of this project is to have an ansible-role we can use in each deployment to :
- Improve time on deployment
- Acknowledge and Hashicorp best practices are in place

A big refact of this role has been done. For the moment this role is only valid for Rocky Linux.
Of course we are still improving the role to address our needs.

# How to use this project ?

## Role requirements

As previously explained this role is for Rocky Linux for the moment. 
Some adjustments may be needed for others Linux distros.

This role has been tested with `ansible version 2.15`

## Role variables

All variables are defined and explained in role defaults : `defaults/main.yml`

## Usage

The role should be used as a classical ansible role.
Here is an example of how you can use the role : 

1. Define first your playbook like the following : 

```
---
- hosts: vault_prod
  roles:
    - ansible-vault
```

2. Ensure you have a inventory file containing the `vault_prod` group with variables

```
[vault_prod]
40.114.204.231
13.94.172.243
13.80.245.122
```

3. Ensure the `ansible-vault` role has been defined in ansible role path.
If need you can use `ANSIBLE_ROLES_PATH` to define the path to the role (useful for testing purpose). 

> export ANSIBLE_ROLES_PATH=/workspaces

4. Run the playbook :

> ansible-playbook -i inventory play.yml
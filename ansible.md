# Ansible

- [Ansible](#ansible)
  - [Intro to Ansible](#intro-to-ansible)
  - [How does it work?](#how-does-it-work)
  - [How do we set up Ansible?](#how-do-we-set-up-ansible)
    - [Controller](#controller)


## Intro to Ansible
- Ansible is a configuration management tool. 
- Development is lead by Red Hat. 
- Written in Python
- Originally for managing linux servers
- Main use cases:
  - config management  
  - Application deployment
  - can manage infrastructure (orchestration)
- works with most systems

## How does it work?
- instructions written in YAML
  - called "playbooks"
- inventory used to specify the machine it needs to configure
- machines it configures = Target Nodes
- agentless architecture
- accesses target nodes through ssh. Needs python on target nodes.
- Ansible machine storing playbooks, inventory, etc is called the Ansible Controller

## How do we set up Ansible?

### Controller


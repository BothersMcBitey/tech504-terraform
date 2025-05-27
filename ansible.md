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
 - We gotta make sure everything's updated and upgraded
 - Install ansible
 - Make sure the private key to access the target machines is on the controller 
 - add target nodes to /etc/ansible/hosts
   - Target node needs to be added with username and path to private key
     - Syntax is `ec2-app-instance ansible_host=[ip] ansible_user=[login] ansible_ssh_private_key_file=[credentials]`
   - `ansible all -m ping` checks if you can access them
 - Run commands on inventory machines from controller
   - `ansible-inventory --graph` or `ansible-inventory --list` will show you the current inventory
   - `ansible web -a [args]` runs ad-hoc commands
     - e.g. `ansible web -a "uname -a"`  give info about the name of each machine in inventory. `ansible web -a "date"` shows the date as each machine knows it.
     - By default, commands use `ansible.builtin.command`
   - other modules exist (e.g. `ansible.builtin.apt`). It's better to use specific modules where possible, as it's more idempotent. An example is `ansible we -m ansible.builtin.apt -a "upgrade=dist" --become`.
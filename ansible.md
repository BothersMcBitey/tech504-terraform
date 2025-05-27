# Ansible

- [Ansible](#ansible)
- [How does it work?](#how-does-it-work)
- [How do we use Ansible?](#how-do-we-use-ansible)
  - [Controller](#controller)
  - [Playbooks](#playbooks)


##Intro to Ansible
- Ansible is a configuration management tool. 
- Development is lead by Red Hat. 
- Written in Python
- Originally for managing linux servers
- Main use cases:
  - config management  
  - Application deployment
  - can manage infrastructure (orchestration)
- works with most systems

# How does it work?
- instructions written in YAML
  - called "playbooks"
- inventory used to specify the machine it needs to configure
- machines it configures = Target Nodes
- agentless architecture
- accesses target nodes through ssh. Needs python on target nodes.
- Ansible machine storing playbooks, inventory, etc is called the Ansible Controller

# How do we use Ansible?

## Controller
 - We gotta make sure everything's updated and upgraded
 - Install ansible
 - Make sure the private key to access the target machines is on the controller 
 - add target nodes to `/etc/ansible/hosts` (this is your inventory)
   - Target node needs to be added with username and path to private key
     - Syntax is `ec2-app-instance ansible_host=[ip] ansible_user=[login] ansible_ssh_private_key_file=[credentials]`
   - `ansible all -m ping` checks if you can access them
 - Run commands (ad-hoc commands) on inventory machines from controller
   - `ansible-inventory --graph` or `ansible-inventory --list` will show you the current inventory
   - `ansible [group] -a [args]` runs ad-hoc commands
     - e.g. `ansible [group] -a "uname -a"`  gives info about each machine in inventory. `ansible [group] -a "date"` shows the date as each machine knows it.
     - By default, commands use `ansible.builtin.command`.
   - other modules exist (e.g. `ansible.builtin.apt`). It's better to use specific modules where possible, as it's more idempotent. An example is `-m ansible.builtin.apt -a "upgrade=dist" --become`.
   - To send data to your targets, `ansible.builtin.copy -a "src=[] dest=[] mode=XXX"`. Mode lets you set access permissions.

## Playbooks
- written in yaml
- first, name of the 'play', `- name: install nginx play`
- Specify hosts/host groups, `hosts: [name/group]`
- Decide whether or not to gather facts (no is faster), `gather_facts: yes/no`
- Do we give it sudo access? `become: true`
- Instructions are called 'tasks'.
 ``` yaml
  # example of playbook that runs apt update
---
- name: let's update a thing
   hosts: web
   gather_facts: yes
   become: true
   tasks: 
   - name: update the apt cache
     ansible.builtin.apt:
       update_cache: yes
```
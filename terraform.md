# Terraform

- [Terraform](#terraform)
- [Infrastructure as Code](#infrastructure-as-code)
  - [What is IaC?](#what-is-iac)
    - [Benefits](#benefits)
  - [Tools for IaC](#tools-for-iac)
    - [Process of provisioning servers](#process-of-provisioning-servers)
- [Intro to Terraform](#intro-to-terraform)
    - [What is Terraform?](#what-is-terraform)
    - [Why use it?](#why-use-it)
      - [Alternatives](#alternatives)
    - [Why use Terraform in different environments?](#why-use-terraform-in-different-environments)
  - [Terraform commands](#terraform-commands)

# Infrastructure as Code
What's the problem?
- still manually provisioning servers
- Still building infrastructure (firewalls, health checks, etc)

What have we automated so far?
- Vm startup process and images
- Building VMs with instance groups and template

How to solve the problem?
- we want to automate/codify all of it

## What is IaC?
- manage and provision computers through code that's human + machine readable
- can provision infrastructure (servers) and software/settings
- define what you want

### Benefits
Gives speed and simplicity. Reduced human error. Version control of provisioning code. Scalability.

## Tools for IaC
Two types:
- #### Orchestration - managing of infrastructure
  - CloudFormation (AWS)
  - Terraform
  - Arm/Bicep (Azure)
  - Ansible - not design for it, but can do
- #### Config Management - installing & configuring software
  - Ansible - actually made for this one
  - Chef
  - Puppet

### Process of provisioning servers
1. Creating server instances
   - Orchestration tools
2. Configuring OS and software
   - Config Management
3. Deploying applications
   - Config Management
5. Configuring monitoring and logging
   - apparently it depends

# Intro to Terraform

### What is Terraform?
Terraform is an Orchestration tool. It treats infrastructure as immutable and disposable. Uses HCL (Hashicorp Config Language), which is declarative.

### Why use it?
Easy to use. Free and open-source (although the license has changed recently). It's cloud-agnostic, which it does through "providers" - interfaces between terraform and each cloud system. Lots of plugins.

#### Alternatives
Halloumi, which can use different languages.

### Why use Terraform in different environments?
(e.g. production, , dev, testing, QA, staging, etc)
Production
- keep similar environments to tother stages
- easy to modify scale

Dev/testing
- easy to build and destroy

For Disaster Recovery
- version control
- same infrastructure in every region
- almost identical in all cloud platforms

## Terraform commands

- plan (non-destructive)
- apply (destructive), also runs plan
- destroy
- format - prettier
- init - setup folder

Terraform code saved in .tf files. If multiple tfs in folder, it runs all - order shouldn't matter

Automatically locks you into the provider version you first use - can change manually
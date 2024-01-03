# Infrastructure Automation

This repository contains Ansible playbooks and roles for provisioning, securing, and deploying infrastructure and applications.

## Contents

### Security Hardening

- OS hardening playbooks for RHEL/CentOS and Ubuntu following CIS benchmarks
- SSH hardening roles to lock down SSH access 

### Provisioning & Bootstrapping  

- Playbooks for provisioning fresh servers with users, groups, accounts
- Bootstrapping scripts for preparing nodes for automation/configuration management
- Proxmox VM Provisioning

### Software Deployment

Roles for installing and configuring common software packages:

- Docker  
- Golang
- NodeJS
- Python
- Netmaker
- Tailscale
  
### Docker Deployment

Playbooks for deploying and managing Docker containers and services:

- Templated docker-compose files for deploying stacks like:
  - Grafana, Prometheus, Loki, Promtail for monitoring
  - Traefik as reverse proxy
  - Cadvisor for container metrics  
  - Adguard DNS for network-wide ad blocking
  - n8n for workflow automation
   
## Usage
   
A sample inventory is located in `inventory/sample/` directory. Copy the `inventory/sample` to your destination `inventory/my-inventory` by using the command below:

```sh

cp -r ./inventory/sample ./inventory/my-inventory

```

Change variables based on your needs in `inventory/my-inventory/group_vars` directory

Run a playbook. Example:

```sh

ansible-playbook -i inventory/my-inventory/hosts.ini playbooks/ping.yml

```

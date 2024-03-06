### Steps

- Create an inventory file
```ini
[coolify_managed]
managedserver1 traefik_public=true # if traefik needs to listen on 0.0.0.0
managedserver2

[coolify_server]
coolifyserver

[coolify_hosts:children]
```

- Run setup-coolify.yml playbook on this inventory
- SSH into `coolifyserver` and install coolify
- Go to `coolifyserver:8000`
- Register new credentials
- Make sure correct private key is added for coolify server in GUI
- Make sure coolify user is `coolify` and IP address is correct
- Verify correct proxy config is setup
- Start proxy
- Edit `/data/coolify/source/docker-compose.prod.yml` to remove public port mappings
- Edit `/data/coolify/source/docker-compose.prod.yml` to add correct labels for `coolifyserver` so it can be accessed from a domain
- Restart coolify
`docker-compose -f docker-compose.prod.yml -f docker-compose.yml up -d`

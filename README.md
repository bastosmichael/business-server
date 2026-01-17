# Business Server

This project manages a business-focused server running Docker stacks via Terraform. Each stack replaces a commercial SaaS product with a self-hosted open-source alternative, while Portainer stays as the container management plane.

## Project Structure
```
infra/            # Terraform configuration
  bootstrap.sh    # Manual bootstrap script (optional)
  main.tf         # Main Terraform logic
  variables.tf    # Variable definitions
  outputs.tf      # Deployment outputs
  stacks/         # Docker Compose files grouped by service
    appflowy/ calcom/ coolify/ dokku/ docuseal/ erpnext/ gitlab/ jitsi/ libreoffice/
    matomo/ mattermost/ mautic/ nextcloud/ nocodb/ openproject/ plane/ pocketbase/
    prestashop/ prometheus/ supabase/ wekan/ appwrite/ convex/ portainer/
```

## Deployment

1. **Bootstrap and Deploy:**
   Run Terraform from the `infra/` directory. This will bootstrap the server (install Docker) and deploy your selected stacks.

   ```bash
   cd infra
   terraform init
   terraform apply \
     -var="docker_host=ssh://michael@192.168.86.38" \
     -var="enable_portainer=true" \
     -var="enable_appflowy=true" \
     -var="enable_jitsi=true" \
     -var="enable_plane=true" \
     -var="enable_nocodb=true" \
     -var="enable_coolify=true" \
     -var="enable_dokku=true" \
     -var="enable_pocketbase=true" \
     -var="enable_appwrite=true" \
     -var="enable_convex=true" \
     -var="enable_supabase=true" \
     -var="enable_prestashop=true" \
     -var="enable_gitlab=true" \
     -var="enable_mattermost=true" \
     -var="enable_erpnext=true" \
     -var="enable_nextcloud=true" \
     -var="enable_mautic=true" \
     -var="enable_wekan=true" \
     -var="enable_docuseal=true" \
     -var="enable_calcom=true" \
     -var="enable_prometheus=true" \
     -var="enable_matomo=true" \
     -var="enable_libreoffice=true" \
     -var="enable_openproject=true"
   ```

   **Note:** replace `192.168.86.38` with your actual server IP.

2. **Accessing Tools:**
   Terraform's remote bootstrap automatically opens UFW for HTTP/HTTPS (80/443) and the ports associated with any services you enable so they bind to `0.0.0.0` and remain reachable externally.

## SaaS Replacements

| Commercial SaaS | Open Source Alternative | What it does | Default URL |
| --- | --- | --- | --- |
| Notion | AppFlowy | Collaborative documents and knowledge base. | `http://<server-ip>:8001` |
| Zoom | Jitsi | Secure video conferencing with meeting rooms. | `http://<server-ip>:8002` |
| Jira | Plane | Agile project tracking and issue management. | `http://<server-ip>:3000` |
| Airtable | NocoDB | Spreadsheet-like database and API builder. | `http://<server-ip>:8081` |
| Vercel | Coolify | Self-hosted PaaS for deploying apps and databases. | `http://<server-ip>:8003` |
| Heroku | Dokku | Git-push deploys for containerized apps. | `http://<server-ip>:8004` |
| Firebase | PocketBase | Backend-as-a-service with auth + realtime data. | `http://<server-ip>:8090` |
| Firebase | Appwrite | Backend-as-a-service with auth + storage. | `http://<server-ip>:8091` |
| Firebase | Convex | Reactive backend and database for apps. | `http://<server-ip>:8092` |
| Firebase | Supabase | Postgres-backed backend with a web studio. | `http://<server-ip>:8093` |
| Shopify | PrestaShop | E-commerce storefront and catalog management. | `http://<server-ip>:8082` |
| GitHub | GitLab | Git hosting with CI/CD and code reviews. | `http://<server-ip>:8929` |
| Slack | Mattermost | Team chat, channels, and messaging. | `http://<server-ip>:8065` |
| Salesforce CRM | ERPNext | CRM and ERP suite for sales and ops. | `http://<server-ip>:8006` |
| Dropbox | Nextcloud | File sync/share with collaboration features. | `http://<server-ip>:8080` |
| Mailchimp | Mautic | Email marketing automation and campaigns. | `http://<server-ip>:8083` |
| Trello | Wekan | Kanban boards for task tracking. | `http://<server-ip>:8084` |
| DocuSign | Docuseal | Document signing and approval workflows. | `http://<server-ip>:8085` |
| Calendly | Cal.com | Scheduling links and appointment booking. | `http://<server-ip>:8086` |
| Datadog | Prometheus | Metrics collection and alerting. | `http://<server-ip>:9090` |
| Google Analytics | Matomo | Privacy-friendly web analytics. | `http://<server-ip>:8087` |
| Microsoft Office 365 | LibreOffice | Browser-accessed office suite. | `http://<server-ip>:5800` |
| Asana | OpenProject | Project plans, timelines, and tasks. | `http://<server-ip>:8088` |

## Portainer (Management)
* **Portainer:** Web UI for monitoring the Docker host, viewing logs, and updating containers at `http://<server-ip>:9000`.

## System Prerequisites
Before running Terraform, you must ensure:
1.  **SSH Access:** Keys are copied to the server (`ssh-copy-id`).
2.  **Passwordless Sudo:** The user must be able to run sudo without a password for Terraform automation.
    Run this on the server (or via SSH) once:
    ```bash
    ssh -t michael@<server-ip> "echo 'michael ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/michael"
    ```

## Bootstrapping Details
Terraform uses SSH to connect to the server. Ensure you have:
1. SSH access to the server via public key (`ssh-copy-id`).
2. Sudo privileges on the server (NOPASSWD recommended).

## Checking Logs
To check on the logs of the deployed services (example: Portainer), you can SSH into the server and run the docker logs command:

```bash
ssh michael@192.168.86.38 "sudo docker logs -f portainer"
```

terraform {
  required_version = ">= 1.0"

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.2"
    }
  }
}

provider "null" {}

resource "null_resource" "bootstrap_docker" {
  triggers = {
    docker_host   = var.docker_host
    daemon_config = "v1" # Force update for daemon.json entry
  }
  provisioner "local-exec" {
    command = <<EOT
      HOST="${replace(var.docker_host, "ssh://michael@", "")}"
      USER="michael"

      ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "$USER@$HOST" 'bash -s' <<'REMOTE_SCRIPT'
        # Configure Docker default address pools (fixes 'all predefined address pools have been fully subnetted')
        echo '{"default-address-pools":[{"base":"10.0.0.0/8","size":24}]}' | sudo tee /etc/docker/daemon.json > /dev/null
        sudo systemctl restart docker

        # Restart DNS resolver (just in case)
        sudo systemctl restart systemd-resolved || true

        # Create stack dirs
        sudo mkdir -p /opt/portainer /opt/appflowy /opt/jitsi /opt/plane /opt/nocodb /opt/coolify /opt/dokku /opt/pocketbase /opt/appwrite /opt/convex /opt/supabase /opt/prestashop /opt/gitlab /opt/mattermost /opt/erpnext /opt/nextcloud /opt/mautic /opt/wekan /opt/docuseal /opt/calcom /opt/prometheus /opt/matomo /opt/libreoffice /opt/openproject
        sudo mkdir -p /opt/appflowy/data /opt/jitsi/config/web /opt/jitsi/config/prosody /opt/jitsi/config/jicofo /opt/jitsi/config/jvb /opt/plane/db /opt/nocodb/data /opt/coolify/data /opt/dokku/data /opt/pocketbase/pb_data /opt/appwrite/storage /opt/appwrite/db /opt/appwrite/redis /opt/convex/data /opt/supabase/db /opt/prestashop/html /opt/prestashop/db /opt/gitlab/config /opt/gitlab/logs /opt/gitlab/data /opt/mattermost/data /opt/mattermost/db /opt/erpnext/sites /opt/erpnext/db /opt/nextcloud/html /opt/nextcloud/db /opt/mautic/html /opt/mautic/db /opt/wekan/data /opt/wekan/db /opt/docuseal/data /opt/calcom/data /opt/calcom/db /opt/prometheus/data /opt/matomo/html /opt/matomo/db /opt/libreoffice/config /opt/openproject/data
        sudo chown -R 1000:1000 /opt/portainer /opt/appflowy /opt/jitsi /opt/plane /opt/nocodb /opt/coolify /opt/dokku /opt/pocketbase /opt/appwrite /opt/convex /opt/supabase /opt/prestashop /opt/gitlab /opt/mattermost /opt/erpnext /opt/nextcloud /opt/mautic /opt/wekan /opt/docuseal /opt/calcom /opt/prometheus /opt/matomo /opt/libreoffice /opt/openproject || true
REMOTE_SCRIPT
    EOT
  }
}

# Deploy Stacks
resource "null_resource" "deploy_stacks" {
  depends_on = [null_resource.bootstrap_docker]

  triggers = {
    docker_host        = var.docker_host
    enable_portainer   = var.enable_portainer
    enable_appflowy    = var.enable_appflowy
    enable_jitsi       = var.enable_jitsi
    enable_plane       = var.enable_plane
    enable_nocodb      = var.enable_nocodb
    enable_coolify     = var.enable_coolify
    enable_dokku       = var.enable_dokku
    enable_pocketbase  = var.enable_pocketbase
    enable_appwrite    = var.enable_appwrite
    enable_convex      = var.enable_convex
    enable_supabase    = var.enable_supabase
    enable_prestashop  = var.enable_prestashop
    enable_gitlab      = var.enable_gitlab
    enable_mattermost  = var.enable_mattermost
    enable_erpnext     = var.enable_erpnext
    enable_nextcloud   = var.enable_nextcloud
    enable_mautic      = var.enable_mautic
    enable_wekan       = var.enable_wekan
    enable_docuseal    = var.enable_docuseal
    enable_calcom      = var.enable_calcom
    enable_prometheus  = var.enable_prometheus
    enable_matomo      = var.enable_matomo
    enable_libreoffice = var.enable_libreoffice
    enable_openproject = var.enable_openproject
  }

  provisioner "local-exec" {
    command = <<EOT
      # Define HOST and USER
      HOST="${replace(var.docker_host, "ssh://michael@", "")}"
      USER="michael"

      # Copy Compose Files via SCP (renaming on destination to avoid collisions)
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/portainer/docker-compose.yml" "$USER@$HOST:/tmp/portainer.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/appflowy/docker-compose.yml" "$USER@$HOST:/tmp/appflowy.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/jitsi/docker-compose.yml" "$USER@$HOST:/tmp/jitsi.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/plane/docker-compose.yml" "$USER@$HOST:/tmp/plane.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/nocodb/docker-compose.yml" "$USER@$HOST:/tmp/nocodb.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/coolify/docker-compose.yml" "$USER@$HOST:/tmp/coolify.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/dokku/docker-compose.yml" "$USER@$HOST:/tmp/dokku.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/pocketbase/docker-compose.yml" "$USER@$HOST:/tmp/pocketbase.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/appwrite/docker-compose.yml" "$USER@$HOST:/tmp/appwrite.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/convex/docker-compose.yml" "$USER@$HOST:/tmp/convex.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/supabase/docker-compose.yml" "$USER@$HOST:/tmp/supabase.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/prestashop/docker-compose.yml" "$USER@$HOST:/tmp/prestashop.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/gitlab/docker-compose.yml" "$USER@$HOST:/tmp/gitlab.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/mattermost/docker-compose.yml" "$USER@$HOST:/tmp/mattermost.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/erpnext/docker-compose.yml" "$USER@$HOST:/tmp/erpnext.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/nextcloud/docker-compose.yml" "$USER@$HOST:/tmp/nextcloud.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/mautic/docker-compose.yml" "$USER@$HOST:/tmp/mautic.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/wekan/docker-compose.yml" "$USER@$HOST:/tmp/wekan.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/docuseal/docker-compose.yml" "$USER@$HOST:/tmp/docuseal.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/calcom/docker-compose.yml" "$USER@$HOST:/tmp/calcom.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/prometheus/docker-compose.yml" "$USER@$HOST:/tmp/prometheus.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/prometheus/prometheus.yml" "$USER@$HOST:/tmp/prometheus.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/matomo/docker-compose.yml" "$USER@$HOST:/tmp/matomo.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/libreoffice/docker-compose.yml" "$USER@$HOST:/tmp/libreoffice.docker-compose.yml"
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${path.module}/stacks/openproject/docker-compose.yml" "$USER@$HOST:/tmp/openproject.docker-compose.yml"

      # Execute Remote Setup via SSH
      ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "$USER@$HOST" 'bash -s' <<'REMOTE_SCRIPT'
        set -e

        # Helper for retrying commands (fixes transient DNS/network issues)
        function retry {
          local retries=5
          local count=0
          until "$@"; do
            exit=$?
            wait=$((2 ** count))
            count=$((count + 1))
            if [ $count -lt $retries ]; then
              echo "Retry $count/$retries exited $exit, retrying in $wait seconds..."
              sleep $wait
            else
              echo "Retry $count/$retries exited $exit, no more retries left."
              return $exit
            fi
          done
          return 0
        }

        # Wait for containers to finish initial build/health checks
        function wait_for_containers_to_settle {
          local timeout=600
          local interval=5
          local elapsed=0

          while [ $elapsed -lt $timeout ]; do
            local unsettled
            unsettled=$(sudo docker ps -a --format '{{.Names}} {{.Status}}' | \
              grep -v '^portainer ' | \
              grep -E 'health: starting|Restarting|Created' || true)

            if [ -z "$unsettled" ]; then
              echo "Containers have settled."
              return 0
            fi

            echo "Waiting for containers to settle... ($elapsed/$${timeout}s)"
            sleep $interval
            elapsed=$((elapsed + interval))
          done

          echo "Timed out waiting for containers to settle. Proceeding anyway."
          return 1
        }

        # Restart DNS resolver to fix "server misbehaving" errors
        sudo systemctl restart systemd-resolved || true

        # Ensure directories exist (in case bootstrap didn't run or new ones matched)
        sudo mkdir -p /opt/portainer /opt/appflowy /opt/jitsi /opt/plane /opt/nocodb /opt/coolify /opt/dokku /opt/pocketbase /opt/appwrite /opt/convex /opt/supabase /opt/prestashop /opt/gitlab /opt/mattermost /opt/erpnext /opt/nextcloud /opt/mautic /opt/wekan /opt/docuseal /opt/calcom /opt/prometheus /opt/matomo /opt/libreoffice /opt/openproject
        sudo mkdir -p /opt/appflowy/data /opt/jitsi/config/web /opt/jitsi/config/prosody /opt/jitsi/config/jicofo /opt/jitsi/config/jvb /opt/plane/db /opt/nocodb/data /opt/coolify/data /opt/dokku/data /opt/pocketbase/pb_data /opt/appwrite/storage /opt/appwrite/db /opt/appwrite/redis /opt/convex/data /opt/supabase/db /opt/prestashop/html /opt/prestashop/db /opt/gitlab/config /opt/gitlab/logs /opt/gitlab/data /opt/mattermost/data /opt/mattermost/db /opt/erpnext/sites /opt/erpnext/db /opt/nextcloud/html /opt/nextcloud/db /opt/mautic/html /opt/mautic/db /opt/wekan/data /opt/wekan/db /opt/docuseal/data /opt/calcom/data /opt/calcom/db /opt/prometheus/data /opt/matomo/html /opt/matomo/db /opt/libreoffice/config /opt/openproject/data
        sudo chown -R 1000:1000 /opt/portainer /opt/appflowy /opt/jitsi /opt/plane /opt/nocodb /opt/coolify /opt/dokku /opt/pocketbase /opt/appwrite /opt/convex /opt/supabase /opt/prestashop /opt/gitlab /opt/mattermost /opt/erpnext /opt/nextcloud /opt/mautic /opt/wekan /opt/docuseal /opt/calcom /opt/prometheus /opt/matomo /opt/libreoffice /opt/openproject || true

        # Configure Firewall (UFW)
        echo "Configuring Firewall..."
        sudo ufw allow 22/tcp  # SSH
        sudo ufw allow 80/tcp  # HTTP (reverse proxies / direct web access)
        sudo ufw allow 443/tcp # HTTPS (reverse proxies / direct web access)
        sudo ufw allow 8000/tcp # Portainer edge
        sudo ufw allow 9000/tcp # Portainer
        sudo ufw allow 8001/tcp # AppFlowy
        sudo ufw allow 8002/tcp # Jitsi Meet
        sudo ufw allow 10000/udp # Jitsi media
        sudo ufw allow 3000/tcp # Plane UI
        sudo ufw allow 8005/tcp # Plane API
        sudo ufw allow 8081/tcp # NocoDB
        sudo ufw allow 8003/tcp # Coolify
        sudo ufw allow 8004/tcp # Dokku HTTP
        sudo ufw allow 8444/tcp # Dokku HTTPS
        sudo ufw allow 8022/tcp # Dokku SSH
        sudo ufw allow 8090/tcp # PocketBase
        sudo ufw allow 8091/tcp # Appwrite
        sudo ufw allow 8092/tcp # Convex
        sudo ufw allow 8093/tcp # Supabase Studio
        sudo ufw allow 8082/tcp # PrestaShop
        sudo ufw allow 8929/tcp # GitLab HTTP
        sudo ufw allow 9443/tcp # GitLab HTTPS
        sudo ufw allow 2222/tcp # GitLab SSH
        sudo ufw allow 8065/tcp # Mattermost
        sudo ufw allow 8006/tcp # ERPNext
        sudo ufw allow 8080/tcp # Nextcloud
        sudo ufw allow 8083/tcp # Mautic
        sudo ufw allow 8084/tcp # Wekan
        sudo ufw allow 8085/tcp # Docuseal
        sudo ufw allow 8086/tcp # Cal.com
        sudo ufw allow 9090/tcp # Prometheus
        sudo ufw allow 8087/tcp # Matomo
        sudo ufw allow 5800/tcp # LibreOffice
        sudo ufw allow 8088/tcp # OpenProject
        sudo ufw --force enable || true

        # Move files to correct locations
        sudo mv /tmp/portainer.docker-compose.yml /opt/portainer/docker-compose.yml
        sudo mv /tmp/appflowy.docker-compose.yml /opt/appflowy/docker-compose.yml
        sudo mv /tmp/jitsi.docker-compose.yml /opt/jitsi/docker-compose.yml
        sudo mv /tmp/plane.docker-compose.yml /opt/plane/docker-compose.yml
        sudo mv /tmp/nocodb.docker-compose.yml /opt/nocodb/docker-compose.yml
        sudo mv /tmp/coolify.docker-compose.yml /opt/coolify/docker-compose.yml
        sudo mv /tmp/dokku.docker-compose.yml /opt/dokku/docker-compose.yml
        sudo mv /tmp/pocketbase.docker-compose.yml /opt/pocketbase/docker-compose.yml
        sudo mv /tmp/appwrite.docker-compose.yml /opt/appwrite/docker-compose.yml
        sudo mv /tmp/convex.docker-compose.yml /opt/convex/docker-compose.yml
        sudo mv /tmp/supabase.docker-compose.yml /opt/supabase/docker-compose.yml
        sudo mv /tmp/prestashop.docker-compose.yml /opt/prestashop/docker-compose.yml
        sudo mv /tmp/gitlab.docker-compose.yml /opt/gitlab/docker-compose.yml
        sudo mv /tmp/mattermost.docker-compose.yml /opt/mattermost/docker-compose.yml
        sudo mv /tmp/erpnext.docker-compose.yml /opt/erpnext/docker-compose.yml
        sudo mv /tmp/nextcloud.docker-compose.yml /opt/nextcloud/docker-compose.yml
        sudo mv /tmp/mautic.docker-compose.yml /opt/mautic/docker-compose.yml
        sudo mv /tmp/wekan.docker-compose.yml /opt/wekan/docker-compose.yml
        sudo mv /tmp/docuseal.docker-compose.yml /opt/docuseal/docker-compose.yml
        sudo mv /tmp/calcom.docker-compose.yml /opt/calcom/docker-compose.yml
        sudo mv /tmp/prometheus.docker-compose.yml /opt/prometheus/docker-compose.yml
        sudo mv /tmp/prometheus.yml /opt/prometheus/prometheus.yml
        sudo mv /tmp/matomo.docker-compose.yml /opt/matomo/docker-compose.yml
        sudo mv /tmp/libreoffice.docker-compose.yml /opt/libreoffice/docker-compose.yml
        sudo mv /tmp/openproject.docker-compose.yml /opt/openproject/docker-compose.yml

        # Deploy Stacks
        ${var.enable_portainer ? "cd /opt/portainer && (sudo docker rm -f portainer || true) && retry sudo docker compose up -d" : "echo 'Skipping Portainer'"}
        ${var.enable_appflowy ? "cd /opt/appflowy && (sudo docker rm -f appflowy || true) && retry sudo docker compose up -d" : "echo 'Skipping AppFlowy'"}
        ${var.enable_jitsi ? "cd /opt/jitsi && (sudo docker rm -f jitsi-web jitsi-prosody jitsi-jicofo jitsi-jvb || true) && retry sudo docker compose up -d" : "echo 'Skipping Jitsi'"}
        ${var.enable_plane ? "cd /opt/plane && (sudo docker rm -f plane-db plane-redis plane-api plane-worker plane-web || true) && retry sudo docker compose up -d" : "echo 'Skipping Plane'"}
        ${var.enable_nocodb ? "cd /opt/nocodb && (sudo docker rm -f nocodb || true) && retry sudo docker compose up -d" : "echo 'Skipping NocoDB'"}
        ${var.enable_coolify ? "cd /opt/coolify && (sudo docker rm -f coolify || true) && retry sudo docker compose up -d" : "echo 'Skipping Coolify'"}
        ${var.enable_dokku ? "cd /opt/dokku && (sudo docker rm -f dokku || true) && retry sudo docker compose up -d" : "echo 'Skipping Dokku'"}
        ${var.enable_pocketbase ? "cd /opt/pocketbase && (sudo docker rm -f pocketbase || true) && retry sudo docker compose up -d" : "echo 'Skipping PocketBase'"}
        ${var.enable_appwrite ? "cd /opt/appwrite && (sudo docker rm -f appwrite appwrite-db appwrite-redis || true) && retry sudo docker compose up -d" : "echo 'Skipping Appwrite'"}
        ${var.enable_convex ? "cd /opt/convex && (sudo docker rm -f convex || true) && retry sudo docker compose up -d" : "echo 'Skipping Convex'"}
        ${var.enable_supabase ? "cd /opt/supabase && (sudo docker rm -f supabase-db supabase-studio || true) && retry sudo docker compose up -d" : "echo 'Skipping Supabase'"}
        ${var.enable_prestashop ? "cd /opt/prestashop && (sudo docker rm -f prestashop prestashop-db || true) && retry sudo docker compose up -d" : "echo 'Skipping PrestaShop'"}
        ${var.enable_gitlab ? "cd /opt/gitlab && (sudo docker rm -f gitlab || true) && retry sudo docker compose up -d" : "echo 'Skipping GitLab'"}
        ${var.enable_mattermost ? "cd /opt/mattermost && (sudo docker rm -f mattermost mattermost-db || true) && retry sudo docker compose up -d" : "echo 'Skipping Mattermost'"}
        ${var.enable_erpnext ? "cd /opt/erpnext && (sudo docker rm -f erpnext erpnext-db || true) && retry sudo docker compose up -d" : "echo 'Skipping ERPNext'"}
        ${var.enable_nextcloud ? "cd /opt/nextcloud && (sudo docker rm -f nextcloud nextcloud-db || true) && retry sudo docker compose up -d" : "echo 'Skipping Nextcloud'"}
        ${var.enable_mautic ? "cd /opt/mautic && (sudo docker rm -f mautic mautic-db || true) && retry sudo docker compose up -d" : "echo 'Skipping Mautic'"}
        ${var.enable_wekan ? "cd /opt/wekan && (sudo docker rm -f wekan wekan-db || true) && retry sudo docker compose up -d" : "echo 'Skipping Wekan'"}
        ${var.enable_docuseal ? "cd /opt/docuseal && (sudo docker rm -f docuseal || true) && retry sudo docker compose up -d" : "echo 'Skipping Docuseal'"}
        ${var.enable_calcom ? "cd /opt/calcom && (sudo docker rm -f calcom calcom-db || true) && retry sudo docker compose up -d" : "echo 'Skipping Cal.com'"}
        ${var.enable_prometheus ? "cd /opt/prometheus && (sudo docker rm -f prometheus || true) && retry sudo docker compose up -d" : "echo 'Skipping Prometheus'"}
        ${var.enable_matomo ? "cd /opt/matomo && (sudo docker rm -f matomo matomo-db || true) && retry sudo docker compose up -d" : "echo 'Skipping Matomo'"}
        ${var.enable_libreoffice ? "cd /opt/libreoffice && (sudo docker rm -f libreoffice || true) && retry sudo docker compose up -d" : "echo 'Skipping LibreOffice'"}
        ${var.enable_openproject ? "cd /opt/openproject && (sudo docker rm -f openproject || true) && retry sudo docker compose up -d" : "echo 'Skipping OpenProject'"}

        # Pause all containers except Portainer after they have settled
        wait_for_containers_to_settle || true
        NON_PORTAINER_CONTAINERS=$(sudo docker ps --filter "status=running" --format '{{.Names}}' | grep -v '^portainer$' || true)

        if [ -n "$NON_PORTAINER_CONTAINERS" ]; then
          echo "Pausing non-Portainer containers: $NON_PORTAINER_CONTAINERS"
          echo "$NON_PORTAINER_CONTAINERS" | xargs -r sudo docker pause
        else
          echo "No non-Portainer containers are running to pause."
        fi
REMOTE_SCRIPT
    EOT
  }
}

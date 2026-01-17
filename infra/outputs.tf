locals {
  docker_host_address = var.docker_host != "unix:///var/run/docker.sock" ? replace(replace(var.docker_host, "ssh://", ""), "michael@", "") : "localhost"
}

output "portainer_url" {
  description = "URL to access Portainer"
  value       = var.enable_portainer ? "http://${local.docker_host_address}:9000" : "Portainer not enabled"
}

output "appflowy_url" {
  description = "URL to access AppFlowy"
  value       = var.enable_appflowy ? "http://${local.docker_host_address}:8001" : "AppFlowy not enabled"
}

output "jitsi_url" {
  description = "URL to access Jitsi"
  value       = var.enable_jitsi ? "http://${local.docker_host_address}:8002" : "Jitsi not enabled"
}

output "plane_url" {
  description = "URL to access Plane"
  value       = var.enable_plane ? "http://${local.docker_host_address}:3000" : "Plane not enabled"
}

output "nocodb_url" {
  description = "URL to access NocoDB"
  value       = var.enable_nocodb ? "http://${local.docker_host_address}:8081" : "NocoDB not enabled"
}

output "coolify_url" {
  description = "URL to access Coolify"
  value       = var.enable_coolify ? "http://${local.docker_host_address}:8003" : "Coolify not enabled"
}

output "dokku_url" {
  description = "URL to access Dokku"
  value       = var.enable_dokku ? "http://${local.docker_host_address}:8004" : "Dokku not enabled"
}

output "pocketbase_url" {
  description = "URL to access PocketBase"
  value       = var.enable_pocketbase ? "http://${local.docker_host_address}:8090" : "PocketBase not enabled"
}

output "appwrite_url" {
  description = "URL to access Appwrite"
  value       = var.enable_appwrite ? "http://${local.docker_host_address}:8091" : "Appwrite not enabled"
}

output "convex_url" {
  description = "URL to access Convex"
  value       = var.enable_convex ? "http://${local.docker_host_address}:8092" : "Convex not enabled"
}

output "supabase_url" {
  description = "URL to access Supabase Studio"
  value       = var.enable_supabase ? "http://${local.docker_host_address}:8093" : "Supabase not enabled"
}

output "prestashop_url" {
  description = "URL to access PrestaShop"
  value       = var.enable_prestashop ? "http://${local.docker_host_address}:8082" : "PrestaShop not enabled"
}

output "gitlab_url" {
  description = "URL to access GitLab"
  value       = var.enable_gitlab ? "http://${local.docker_host_address}:8929" : "GitLab not enabled"
}

output "mattermost_url" {
  description = "URL to access Mattermost"
  value       = var.enable_mattermost ? "http://${local.docker_host_address}:8065" : "Mattermost not enabled"
}

output "erpnext_url" {
  description = "URL to access ERPNext"
  value       = var.enable_erpnext ? "http://${local.docker_host_address}:8006" : "ERPNext not enabled"
}

output "nextcloud_url" {
  description = "URL to access Nextcloud"
  value       = var.enable_nextcloud ? "http://${local.docker_host_address}:8080" : "Nextcloud not enabled"
}

output "mautic_url" {
  description = "URL to access Mautic"
  value       = var.enable_mautic ? "http://${local.docker_host_address}:8083" : "Mautic not enabled"
}

output "wekan_url" {
  description = "URL to access Wekan"
  value       = var.enable_wekan ? "http://${local.docker_host_address}:8084" : "Wekan not enabled"
}

output "docuseal_url" {
  description = "URL to access Docuseal"
  value       = var.enable_docuseal ? "http://${local.docker_host_address}:8085" : "Docuseal not enabled"
}

output "calcom_url" {
  description = "URL to access Cal.com"
  value       = var.enable_calcom ? "http://${local.docker_host_address}:8086" : "Cal.com not enabled"
}

output "prometheus_url" {
  description = "URL to access Prometheus"
  value       = var.enable_prometheus ? "http://${local.docker_host_address}:9090" : "Prometheus not enabled"
}

output "matomo_url" {
  description = "URL to access Matomo"
  value       = var.enable_matomo ? "http://${local.docker_host_address}:8087" : "Matomo not enabled"
}

output "libreoffice_url" {
  description = "URL to access LibreOffice"
  value       = var.enable_libreoffice ? "http://${local.docker_host_address}:5800" : "LibreOffice not enabled"
}

output "openproject_url" {
  description = "URL to access OpenProject"
  value       = var.enable_openproject ? "http://${local.docker_host_address}:8088" : "OpenProject not enabled"
}

output "deployed_stacks" {
  description = "List of deployed stacks"
  value = concat(
    var.enable_portainer ? ["portainer"] : [],
    var.enable_appflowy ? ["appflowy"] : [],
    var.enable_jitsi ? ["jitsi"] : [],
    var.enable_plane ? ["plane"] : [],
    var.enable_nocodb ? ["nocodb"] : [],
    var.enable_coolify ? ["coolify"] : [],
    var.enable_dokku ? ["dokku"] : [],
    var.enable_pocketbase ? ["pocketbase"] : [],
    var.enable_appwrite ? ["appwrite"] : [],
    var.enable_convex ? ["convex"] : [],
    var.enable_supabase ? ["supabase"] : [],
    var.enable_prestashop ? ["prestashop"] : [],
    var.enable_gitlab ? ["gitlab"] : [],
    var.enable_mattermost ? ["mattermost"] : [],
    var.enable_erpnext ? ["erpnext"] : [],
    var.enable_nextcloud ? ["nextcloud"] : [],
    var.enable_mautic ? ["mautic"] : [],
    var.enable_wekan ? ["wekan"] : [],
    var.enable_docuseal ? ["docuseal"] : [],
    var.enable_calcom ? ["calcom"] : [],
    var.enable_prometheus ? ["prometheus"] : [],
    var.enable_matomo ? ["matomo"] : [],
    var.enable_libreoffice ? ["libreoffice"] : [],
    var.enable_openproject ? ["openproject"] : []
  )
}

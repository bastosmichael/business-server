locals {
  docker_host_address = var.docker_host != "unix:///var/run/docker.sock" ? replace(replace(var.docker_host, "ssh://", ""), "michael@", "") : "localhost"
}

output "portainer_url" {
  description = "URL to access Portainer"
  value       = var.enable_portainer ? "http://${local.docker_host_address}:9000" : "Portainer not enabled"
}

output "plex_url" {
  description = "URL to access Plex"
  value       = var.enable_plex ? "http://${local.docker_host_address}:32400/web" : "Plex not enabled"
}

output "jellyfin_url" {
  description = "URL to access Jellyfin"
  value       = var.enable_jellyfin ? "http://${local.docker_host_address}:8096" : "Jellyfin not enabled"
}

output "immich_url" {
  description = "URL to access Immich"
  value       = var.enable_immich ? "http://${local.docker_host_address}:2283" : "Immich not enabled"
}

output "navidrome_url" {
  description = "URL to access Navidrome"
  value       = var.enable_navidrome ? "http://${local.docker_host_address}:4533" : "Navidrome not enabled"
}

output "audiobookshelf_url" {
  description = "URL to access Audiobookshelf"
  value       = var.enable_audiobookshelf ? "http://${local.docker_host_address}:13378" : "Audiobookshelf not enabled"
}

output "nextcloud_url" {
  description = "URL to access Nextcloud"
  value       = var.enable_nextcloud ? "http://${local.docker_host_address}:8080" : "Nextcloud not enabled"
}

output "deployed_stacks" {
  description = "List of deployed stacks"
  value = concat(
    var.enable_portainer ? ["portainer"] : [],
    var.enable_plex ? ["plex"] : [],
    var.enable_jellyfin ? ["jellyfin"] : [],
    var.enable_immich ? ["immich"] : [],
    var.enable_navidrome ? ["navidrome"] : [],
    var.enable_audiobookshelf ? ["audiobookshelf"] : [],
    var.enable_nextcloud ? ["nextcloud"] : [],
    var.enable_nginxproxymanager ? ["nginxproxymanager"] : [],
    var.enable_startpage ? ["startpage"] : [],
    var.enable_vaultwarden ? ["vaultwarden"] : [],
    var.enable_hoarder ? ["hoarder"] : [],
    var.enable_docmost ? ["docmost"] : [],
    var.enable_octoprint ? ["octoprint"] : [],
    var.enable_arrfiles ? ["arrfiles"] : [],
    var.enable_tautulli ? ["tautulli"] : [],
    var.enable_overseerr ? ["overseerr"] : [],
    var.enable_radarr ? ["radarr"] : [],
    var.enable_sonarr ? ["sonarr"] : [],
    var.enable_lidarr ? ["lidarr"] : [],
    var.enable_bazarr ? ["bazarr"] : [],
    var.enable_prowlarr ? ["prowlarr"] : [],
    var.enable_qbittorrent ? ["qbittorrent"] : [],
    var.enable_nzbget ? ["nzbget"] : [],
    var.enable_homeassistant ? ["homeassistant"] : [],
    var.enable_zigbee2mqtt ? ["zigbee2mqtt"] : [],
    var.enable_frigate ? ["frigate"] : [],
    var.enable_grafana ? ["grafana"] : [],
    var.enable_influxdb ? ["influxdb"] : [],
    var.enable_prometheus ? ["prometheus"] : []
  )
}

variable "docker_host" {
  description = "Docker daemon socket to connect to"
  type        = string
  default     = "unix:///var/run/docker.sock"
}

variable "enable_portainer" {
  description = "Enable Portainer stack deployment"
  type        = bool
  default     = true
}

variable "enable_appflowy" {
  description = "Enable AppFlowy stack deployment"
  type        = bool
  default     = false
}

variable "enable_jitsi" {
  description = "Enable Jitsi stack deployment"
  type        = bool
  default     = false
}

variable "enable_plane" {
  description = "Enable Plane stack deployment"
  type        = bool
  default     = false
}

variable "enable_nocodb" {
  description = "Enable NocoDB stack deployment"
  type        = bool
  default     = false
}

variable "enable_coolify" {
  description = "Enable Coolify stack deployment"
  type        = bool
  default     = false
}

variable "enable_dokku" {
  description = "Enable Dokku stack deployment"
  type        = bool
  default     = false
}

variable "enable_pocketbase" {
  description = "Enable PocketBase stack deployment"
  type        = bool
  default     = false
}

variable "enable_appwrite" {
  description = "Enable Appwrite stack deployment"
  type        = bool
  default     = false
}

variable "enable_convex" {
  description = "Enable Convex stack deployment"
  type        = bool
  default     = false
}

variable "enable_supabase" {
  description = "Enable Supabase stack deployment"
  type        = bool
  default     = false
}

variable "enable_prestashop" {
  description = "Enable PrestaShop stack deployment"
  type        = bool
  default     = false
}

variable "enable_gitlab" {
  description = "Enable GitLab stack deployment"
  type        = bool
  default     = false
}

variable "enable_mattermost" {
  description = "Enable Mattermost stack deployment"
  type        = bool
  default     = false
}

variable "enable_erpnext" {
  description = "Enable ERPNext stack deployment"
  type        = bool
  default     = false
}

variable "enable_nextcloud" {
  description = "Enable Nextcloud stack deployment"
  type        = bool
  default     = false
}

variable "enable_mautic" {
  description = "Enable Mautic stack deployment"
  type        = bool
  default     = false
}

variable "enable_wekan" {
  description = "Enable Wekan stack deployment"
  type        = bool
  default     = false
}

variable "enable_docuseal" {
  description = "Enable Docuseal stack deployment"
  type        = bool
  default     = false
}

variable "enable_calcom" {
  description = "Enable Cal.com stack deployment"
  type        = bool
  default     = false
}

variable "enable_prometheus" {
  description = "Enable Prometheus stack deployment"
  type        = bool
  default     = false
}

variable "enable_matomo" {
  description = "Enable Matomo stack deployment"
  type        = bool
  default     = false
}

variable "enable_libreoffice" {
  description = "Enable LibreOffice stack deployment"
  type        = bool
  default     = false
}

variable "enable_openproject" {
  description = "Enable OpenProject stack deployment"
  type        = bool
  default     = false
}

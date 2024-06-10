resource "kubernetes_deployment" "rclone" {
  metadata {
    name = "rclone"
    namespace = kubernetes_namespace.rclone.metadata[0].name
    labels = {
      app = "rclone-sync"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "rclone-sync"
      }
    }
    template {
      metadata {
        labels = {
          app = "rclone-sync"
        }
      }
      spec {
        container {
          name = "rclone"
          image = "rclone/rclone:latest"
          command = ["sh", "-c"]
          args = ["sleep 600 && rclone sync OneDrive:/Backup GoogleDrive:/Backup -P && rclone sync OneDrive:/Backup /data -P"]
          resources {
            limits = {
              cpu    = "100m"
              memory = "200Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "200Mi"
            }
          }
          volume_mount {
             name       = "rclone-passwd"
             mount_path = "/etc/passwd"
             read_only = true
           }
           volume_mount {
             name       = "rclone-group"
             mount_path = "/etc/group"
             read_only = true
           }
           volume_mount {
             name       = "rclone-conf"
             mount_path = "/root/.rclone.conf"
             read_only = true
           }
           volume_mount {
             name       = "rclonebackup"
             mount_path = "/data"
           }
        }
        volume {
          name = "rclone-passwd"
          host_path {
            path = "/etc/passwd"
          }
        }
        volume {
          name = "rclone-group"
          host_path{
            path = "/etc/group"
          }
        }
        volume {
          name = "rclone-conf"
          host_path{
            path = "/var/rclone-conf/rclone.conf"
          }
        }
        volume {
          name = "rclonebackup"
          host_path{
            path = "/NAS"
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "vscode-server" {
  metadata {
    name = "vscode-server"
    namespace = kubernetes_namespace.vscode.metadata[0].name
    labels = {
      app = "vscode-server"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "vscode-server"
      }
    }
    template {
      metadata {
        labels = {
          app = "vscode-server"
        }
      }
      spec {
        container {
          image = "codercom/code-server:latest"
	        name  = "vscode-server"
          port {
            container_port = 3000
          }
	        env {
            name = "PORT"
            value = 3000
          }
          env {
            name = "PASSWORD"
            value = "Changeme123!"
          }
          liveness_probe {
            http_get {
              path = "/"
              port = 3000
            }
            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "pigallery2" {
  metadata {
    name = "pigallery2"
    namespace = kubernetes_namespace.pigallery2.metadata[0].name
    labels = {
      app = "pigallery2"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "pigallery2"
      }
    }
    template {
      metadata {
        labels = {
          app = "pigallery2"
        }
      }
      spec {
        container {
          image = "bpatrik/pigallery2:latest"
	        name  = "pigallery2"
          port {
            container_port = 80
          }
          env {
            name = "NODE_ENV"
            value = "Production"
          }
          env {
            name = "Server-Log-level"
            value = "debug"
          }
          env {
            name = "Sharing-enabled"
            value = "false"
          }
          volume_mount {
             name       = "db"
             mount_path = "/app/data/db"
          }
          volume_mount {
             name       = "config"
             mount_path = "/app/data/config"
          }
          volume_mount {
             name       = "images"
             mount_path = "/app/data/images"
             read_only = true
          }
          volume_mount {
             name       = "tmp"
             mount_path = "/app/data/tmp"
          }
          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
        volume {
          name = "db"
          host_path {
            path = "/var/pigallery2/db"
          }
        }
        volume {
          name = "config"
          host_path {
            path = "/var/pigallery2/config"
          }
        }
        volume {
          name = "images"
          host_path {
            path = "/NAS/Pictures"
          }
        }
        volume {
          name = "tmp"
          host_path {
            path = "/var/pigallery2/tmp"
          }
        }
      }
    }
  }
}

# resource "kubernetes_deployment" "jellyfin" {
#   metadata {
#     name = "jellyfin"
#     namespace = kubernetes_namespace.jellyfin.metadata[0].name
#     labels = {
#       app = "jellyfin"
#     }
#   }
#   spec {
#     replicas = 1
#     selector {
#       match_labels = {
#         app = "jellyfin"
#       }
#     }
#     template {
#       metadata {
#         labels = {
#           app = "jellyfin"
#         }
#       }
#       spec {
#         container {
#           image = "jellyfin/jellyfin:latest"
# 	        name  = "jellyfin"
#           port {
#             container_port = 80
#           }
#           #volume_mount {
#           #   name       = "db"
#           #   mount_path = "/app/data/db"
#           #}
#           liveness_probe {
#             http_get {
#               path = "/"
#               port = 80
#             }
#             initial_delay_seconds = 3
#             period_seconds        = 3
#           }
#         }
#         #volume {
#         #  name = "db"
#         #  host_path {
#         #    path = "/var/pigallery2/db"
#         #  }
#         #}
#       }
#     }
#   }
# }

#  #--volume /path/to/config:/config \ # Alternatively --volume jellyfin-config:/config
#  #--volume /path/to/cache:/cache \ # Alternatively --volume jellyfin-cache:/cache
#  #--mount type=bind,source=/path/to/media,target=/media \

# # jellyfin env variables:
# #["[JELLYFIN_CONFIG_DIR, /config/config]"
# #"[JELLYFIN_WEB_DIR, /jellyfin/jellyfin-web]"
# #"[JELLYFIN_DATA_DIR, /config]"
# #"[DOTNET_SYSTEM_GLOBALIZATION_INVARIANT, 1]"
# #"[JELLYFIN_FFMPEG, /usr/lib/jellyfin-ffmpeg/ffmpeg]"
# #"[JELLYFIN_LOG_DIR, /config/log]"
# #"[JELLYFIN_CACHE_DIR, /cache]"]
# #(Don't think I need to use all of these)
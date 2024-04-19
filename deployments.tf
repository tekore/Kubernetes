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
          command = ["rclone"]
          args = ["sync", "OneDrive:/Backup", "GoogleDrive:/Backup", "-P"]
          #port {
          #  container_port = 5572
          #}
	        #env {
          #  name = "PORT"
          #  value = 5572
          #}
          resources {
            limits = {
              cpu    = "100m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "512Mi"
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
      }
    }
  }
}
#######################################
resource "kubernetes_deployment" "vscode-server" {
  metadata {
    name = "vscode-server"
    namespace = kubernetes_namespace.vscode.metadata[0].name
    labels = {
      app = "vscode"
    }
  }
  spec {
    replicas = 3
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
          resources {
            limits = {
              cpu    = "2"
              memory = "512Mi"
            }
            requests = {
              cpu    = "1"
              memory = "500Mi"
            }
          }
          liveness_probe {
            http_get {
              path = "/"
              port = 3000
              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }
            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

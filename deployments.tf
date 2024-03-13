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

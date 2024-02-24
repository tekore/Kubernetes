resource "kubernetes_deployment" "httpd" {
  metadata {
    name = "httpd"
    namespace = "testing"
    labels = {
      app = "httpd"
    }
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "httpd"
      }
    }
    template {
      metadata {
        labels = {
          app = "httpd"
        }
      }
      spec {
        container {
          image = "dontrebootme/microbot:v1"
          name  = "httpd"
          port {
            container_port = "80"
          }
          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
          liveness_probe {
            http_get {
              path = "/"
              port = 80
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

resource "kubernetes_ingress_v1" "httpd_service_ingress" {
  metadata {
    name = "httpd-service-ingress"
    namespace = "testing"
  }
  spec {
    default_backend {
      service {
        name = kubernetes_service_v1.httpd-service.metadata[0].name
        port {
          number = 80
        }
      }
    }
    rule {
      http {
        path {
          backend {
            service {
              name = kubernetes_service_v1.httpd-service.metadata[0].name
              port {
                number = 80
              }
            }
          }
          path = "/"
        }
      }
    }
    tls {
      secret_name = "tls-secret"
    }
  }
}

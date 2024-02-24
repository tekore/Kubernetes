resource "kubernetes_service" "httpd-service" {
  metadata {
    name = "httpd-service"
    namespace = "testing"
  }
  spec {
    selector = {
      app = "httpd"
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}

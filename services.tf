resource "kubernetes_service_v1" "httpd-service" {
  metadata {
    name = "httpd-service"
    namespace = "testing"
  }
  spec {
    selector = {
      app = kubernetes_deployment.httpd.metadata[0].name
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}

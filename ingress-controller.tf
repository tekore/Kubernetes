resource "kubernetes_ingress_v1" "vscode-server-ingress" {
  metadata {
    name = "vscode-server-ingress"
    namespace = kubernetes_namespace.vscode.metadata[0].name
  }
  spec {
    rule {
      http {
        path {
          backend {
            service {
              name = kubernetes_service_v1.vscode-server-service.metadata[0].name
              port {
                number = kubernetes_service_v1.vscode-server-service.spec[0].port[0].port
              }
            }
          }
          path = ""
        }
      }
    }
    #tls {
    #  secret_name = "tls-secret"
    #}
  }
}

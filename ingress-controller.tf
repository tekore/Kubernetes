resource "kubernetes_ingress_v1" "vscode-ingress-rule" {
  metadata {
    name = "vscode-ingress-rule"
    namespace = "vscode"
    annotations = {
      #"cert-manager.io/cluster-issuer" = "letsencrypt"
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
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
          path = "/vscode"
        }
      }
    }
    #tls {
    #  secret_name = "tls-secret"
    #}
  }
}

resource "kubernetes_ingress_v1" "pigallery2-ingress-rule" {
  metadata {
    name = "pigallery2-ingress-rule"
    namespace = "pigallery2"
    annotations = {
    #  "cert-manager.io/cluster-issuer" = "letsencrypt"
      #"nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }
  spec {
    rule {
      http {
        path {
          backend {
            service {
              name = kubernetes_service_v1.pigallery2-service.metadata[0].name
              port {
                number = kubernetes_service_v1.pigallery2-service.spec[0].port[0].port
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

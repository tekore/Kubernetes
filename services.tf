resource "kubernetes_service_v1" "vscode-server-service" {
  metadata {
    name = "vscode-server-service"
    namespace = kubernetes_namespace.vscode.metadata[0].name
  }
  spec {
    selector = {
      app = kubernetes_deployment.vscode-server.metadata[0].name
    }
    port {
      port        = 8080
      target_port = kubernetes_deployment.vscode-server.spec[0].template[0].spec[0].container[0].port[0].container_port
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_service_v1" "pigallery2-service" {
  metadata {
    name = "pigallery2-service"
    namespace = kubernetes_namespace.pigallery2.metadata[0].name
  }
  spec {
    selector = {
      app = kubernetes_deployment.pigallery2.metadata[0].name
    }
    port {
      port        = 8070
      target_port = kubernetes_deployment.pigallery2.spec[0].template[0].spec[0].container[0].port[0].container_port
    }
    type = "ClusterIP"
  }
}
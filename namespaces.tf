resource "kubernetes_namespace" "vscode" {
  metadata {
    annotations = {
      name = "vscode"
    }
    name = "vscode"
  }
}

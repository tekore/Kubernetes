resource "kubernetes_namespace" "vscode" {
  metadata {
    annotations = {
      name = "vscode"
    }
    name = "vscode"
  }
}

resource "kubernetes_namespace" "rclone" {
  metadata {
    annotations = {
      name = "rclone"
    }
    name = "rclone"
  }
}
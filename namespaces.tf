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

resource "kubernetes_namespace" "pigallery2" {
  metadata {
    annotations = {
      name = "pigallery2"
    }
    name = "pigallery2"
  }
}

resource "kubernetes_namespace" "jellyfin" {
  metadata {
    annotations = {
      name = "jellyfin"
    }
    name = "jellyfin"
  }
}

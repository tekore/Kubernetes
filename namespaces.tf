resource "kubernetes_namespace" "testing" {
  metadata {
    annotations = {
      name = "testing"
    }
    name = "testing"
  }
}

resource "kubernetes_namespace" "stateful" {
  metadata {
    annotations = {
      name = "stateful"
    }
    name = "stateful"
  }
}

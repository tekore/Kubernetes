#resource "kubernetes_stateful_set" "stateful-test" {
#  metadata {
#    namespace = "stateful"
#    name = "stateful-test"
#  }
#  spec {
#    pod_management_policy  = "Parallel"
#    replicas               = 3
#    revision_history_limit = 5
#    service_name = "prometheus"
#    selector {
#      match_labels = {
#        k8s-app = "statetest"
#      }
#    }
#    template {
#      metadata {
#        labels = {
#          k8s-app = "statetest"
#        }
#      }
#      spec {
#        container {
#          name              = "stateful-test"
#          image             = "dontrebootme/microbot:v1"
#          image_pull_policy = "IfNotPresent"
#          port {
#            container_port = 9090
#          }
#          resources {
#            limits = {
#              cpu    = "200m"
#              memory = "1000Mi"
#            }
#            requests = {
#              cpu    = "200m"
#              memory = "1000Mi"
#            }
#          }
#          volume_mount {
#            name       = "stateclaim"
#            mount_path = "/tmp"
#          }
#        }
#        volume {
#          name = "stateclaim"
#        }
#      }
#    }
#    update_strategy {
#      type = "RollingUpdate"
#      rolling_update {
#        partition = 1
#      }
#    }
#    volume_claim_template {
#      metadata {
#        name = "stateclaim"
#      }
#      spec {
#        access_modes       = ["ReadWriteMany"]
#        storage_class_name = "sclass"
#        resources {
#          requests = {
#            storage = "1Gi"
#          }
#        }
#      }
#    }
#  }
#}

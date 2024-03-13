resource "kubernetes_storage_class" "sclass" {
  metadata {
    name = "sclass"
  }
  storage_provisioner = "microk8s.io/hostpath"
  reclaim_policy      = "Delete"
  volume_binding_mode = "Immediate"
  parameters = {
    type = "pd-standard"
  }
  mount_options = ["file_mode=0700", "dir_mode=0777", "mfsymlinks", "uid=1000", "gid=1000", "nobrl", "cache=none"]
}

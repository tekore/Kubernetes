provider "kubernetes" {
  host = "192.168.1.250:16443"
  client_certificate     = "${file("./../mk8s-certs/client.crt")}"
  client_key             = "${file("./../mk8s-certs/client.key")}"
  cluster_ca_certificate = "${file("./../mk8s-certs/ca.crt")}"
}

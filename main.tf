provider "kubernetes" {
  host = "192.168.1.250:16443"
  client_certificate     = "${file("./../client.crt")}"
  client_key             = "${file("./../client.key")}"
  cluster_ca_certificate = "${file("./../ca.crt")}"
}

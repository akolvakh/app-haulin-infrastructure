#--------------------------------------------------------------
# Kafka
#--------------------------------------------------------------
output "msk_cluster_arn" {
  value = "${aws_msk_cluster.msk-cluster.arn}"
}

output "zookeeper_connect_string" {
  value = "${aws_msk_cluster.msk-cluster.zookeeper_connect_string}"
}

output "zookeeper_connect_string_tls" {
  value = "${aws_msk_cluster.msk-cluster.zookeeper_connect_string_tls}"
}

output "bootstrap_brokers" {
  description = "Plaintext connection host:port pairs"
  value       = "${aws_msk_cluster.msk-cluster.bootstrap_brokers}"
}

output "bootstrap_brokers_sasl_iam" {
  description = "Plaintext connection host:port pairs"
  value       = "${aws_msk_cluster.msk-cluster.bootstrap_brokers_sasl_iam}"
}

output "bootstrap_brokers_sasl_scram" {
  description = "Plaintext connection host:port pairs"
  value       = "${aws_msk_cluster.msk-cluster.bootstrap_brokers_sasl_scram}"
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = "${aws_msk_cluster.msk-cluster.bootstrap_brokers_tls}"
}
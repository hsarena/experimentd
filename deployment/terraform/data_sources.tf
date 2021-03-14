data "civo_kubernetes_cluster" "k8s_cluster" {
  name = var.cluster_name
  depends_on = [ civo_kubernetes_cluster.k8s_cluster ]
}

data "civo_instances_size" "instance_size" {
    filter {
        key = "name"
        values = var.instance_size
    }
}

### Outputs

output "k8s_master_ip" {
  value = data.civo_kubernetes_cluster.k8s_cluster.master_ip
}

output "k8s_status" {
  value = data.civo_kubernetes_cluster.k8s_cluster.status
}

output "kubeconfig" {
  value = data.civo_kubernetes_cluster.k8s_cluster.kubeconfig
}
resource "civo_kubernetes_cluster" "k8s_cluster" {
    name = var.cluster_name
    applications = var.applications
    num_target_nodes = var.node_count
    target_nodes_size = element(data.civo_instances_size.instance_size.sizes, 0).name
}

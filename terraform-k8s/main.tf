# The module in folder 'gcp_gke' defines the Kubernetes Cluster
module "gcp_gke" {
  source   = "./gke"
  projectId = var.projectId
  zone = var.zone
  workers_count = var.workers_count
  machine_type = var.machine_type
}

# The module in folder 'gcp_k8s' defines the Pods and Services
module "gcp_k8s" {
  source   = "./k8s"
  host     = module.gcp_gke.host
  client_certificate     = module.gcp_gke.client_certificate
  client_key             = module.gcp_gke.client_key
  cluster_ca_certificate = module.gcp_gke.cluster_ca_certificate
}
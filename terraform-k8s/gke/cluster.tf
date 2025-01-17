
resource "google_container_cluster" "calculator" {
  name     = "calculator-app"
  project = var.projectId
  location = var.zone
  initial_node_count = var.workers_count

  addons_config {
    network_policy_config {
      disabled = true
    }
  }
  
  node_config {
    machine_type = var.machine_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/compute",
    ]
  }
}
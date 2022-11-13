resource "kubernetes_deployment" "happy" {
  metadata {
    name = "happy-deployment"
    labels = {
      App = "happy"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "happy"
      }
    }
    template {
      metadata {
        labels = {
          App = "happy"
        }
      }
      spec {
        container {
          image = "aaugusto11/happy:1.1"
          name  = "happy"
          image_pull_policy = "Always"

          port {
            container_port = 4000
          }

          readiness_probe {
            http_get {
              path   = "/happy/healthz"
              port   = 4000
              scheme = "HTTP"
            }
            period_seconds    = 10
            success_threshold = 1
            timeout_seconds   = 1
          }
          liveness_probe {
            http_get {
              path   = "/happy/healthz"
              port   = 4000
              scheme = "HTTP"
            }
            period_seconds    = 10
            success_threshold = 1
            timeout_seconds   = 1
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "happy" {
  metadata {
    name = "happy-service"
  }
  spec {
    selector = {
      App = "happy"
    }
    
    port {
      port        = 4000
      target_port = 4000
    }
  }
}

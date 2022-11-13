resource "kubernetes_deployment" "express" {
  metadata {
    name = "expressed-deployment"
    labels = {
      App = "expressed"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "expressed"
      }
    }
    template {
      metadata {
        labels = {
          App = "expressed"
        }
      }
      spec {
        container {
          image = "aaugusto11/expressed:1.1"
          name  = "expressed"
          image_pull_policy = "Always"
          
          port {
            container_port = 3000
          }

          readiness_probe {
            http_get {
              path   = "/express/healthz"
              port   = 3000
              scheme = "HTTP"
            }
            period_seconds    = 10
            success_threshold = 1
            timeout_seconds   = 1
          }
          liveness_probe {
            http_get {
              path   = "/express/healthz"
              port   = 3000
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


resource "kubernetes_service" "express" {
  metadata {
    name = "expressed-service"
  }
  spec {
    selector = {
      App = "expressed"
    }
    
    port {
      port        = 3000
      target_port = 3000
    }
  }
}

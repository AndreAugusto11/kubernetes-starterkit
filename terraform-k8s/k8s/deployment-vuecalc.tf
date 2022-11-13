resource "kubernetes_deployment" "vuecalc" {
  metadata {
    name = "vuecalc-deployment"
    labels = {
      App = "vuecalc"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "vuecalc"
      }
    }
    template {
      metadata {
        labels = {
          App = "vuecalc"
        }
      }
      spec {
        container {
          image = "aaugusto11/vuecalc:1.1"
          name  = "vuecalc"
          image_pull_policy = "Always"

          port {
            container_port = 2000
          }

          env {
            name = "VUE_APP_EXPRESSED_BASE_URL"
            value = "http://${kubernetes_ingress_v1.calculator_ingress.status.0.load_balancer.0.ingress.0.ip}/express"
          }

          env {
            name = "VUE_APP_HAPPY_BASE_URL"
            value = "http://${kubernetes_ingress_v1.calculator_ingress.status.0.load_balancer.0.ingress.0.ip}/happy"
          }

          readiness_probe {
            http_get {
              path   = "/"
              port   = 2000
              scheme = "HTTP"
            }
            period_seconds    = 10
            success_threshold = 1
            timeout_seconds   = 1
          }
          liveness_probe {
            http_get {
              path   = "/"
              port   = 2000
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
  depends_on = [kubernetes_ingress_v1.calculator_ingress]
}


resource "kubernetes_service" "vuecalc" {
  metadata {
    name = "vuecalc-service"
  }
  spec {
    selector = {
      App = "vuecalc"
    }
    
    port {
      port        = 2000
      target_port = 2000
    }
  }
}

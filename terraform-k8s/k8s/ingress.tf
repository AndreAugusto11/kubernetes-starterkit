resource "kubernetes_namespace" "ingress-controller" {
  metadata {
    name = "ingress-controller"
  }
}

resource "helm_release" "ingress-nginx" {
  name            = "ingress-nginx"
  repository      = "https://kubernetes.github.io/ingress-nginx"
  chart           = "ingress-nginx"
  timeout         = 120
  cleanup_on_fail = true
  force_update    = true
  namespace       = kubernetes_namespace.ingress-controller.metadata.0.name
}

resource "kubernetes_ingress_v1" "calculator_ingress" {
  wait_for_load_balancer = true

  metadata {
    name = "calculator-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }

  spec {
    default_backend {
      service {
        name = kubernetes_service.vuecalc.metadata.0.name

        port {
          number = kubernetes_service.vuecalc.spec.0.port.0.port
        }
      }
    }

    rule {
      http {
        path {
          backend {
            service {
              name = kubernetes_service.vuecalc.metadata.0.name

              port {
                number = kubernetes_service.vuecalc.spec.0.port.0.port
              }
            }
          }

          path = "/"
        }

        path {
          backend {
            service {
              name = kubernetes_service.express.metadata.0.name

              port {
                number = kubernetes_service.express.spec.0.port.0.port
              }
            }
          }

          path = "/express"
        }

        path {
          backend {
            service {
              name = kubernetes_service.happy.metadata.0.name

              port {
                number = kubernetes_service.happy.spec.0.port.0.port
              }
            }
          }
          path = "/happy"
        }
      }
    }
  }
  depends_on = [helm_release.ingress-nginx]
}
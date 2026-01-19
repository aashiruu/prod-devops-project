resource "kubernetes_namespace" "dev" {
  metadata { name = "dev" }
}

resource "kubernetes_namespace" "prod" {
  metadata { name = "prod" }
}

resource "kubernetes_namespace" "monitoring" {
  metadata { name = "monitoring" }
}

resource "helm_release" "kube_prometheus" {
  name       = "kube-prometheus-stack"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "56.0.0"

  depends_on = [kubernetes_namespace.monitoring]
  timeout    = 900

  values = [
    <<EOF
grafana:
  adminPassword: "admin123"
  persistence:
    enabled: false

prometheus:
  prometheusSpec:
    storageSpec: 
      emptyDir:
        medium: Memory
    serviceMonitorSelectorNilUsesHelmValues: false
    serviceMonitorSelector: {}
    serviceMonitorNamespaceSelector: {}
    
    retention: 2d

kubeScheduler:
  enabled: false
kubeControllerManager:
  enabled: false
kubeEtcd:
  enabled: false
kubeProxy:
  enabled: false
EOF
  ]
}

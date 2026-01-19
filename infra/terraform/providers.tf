provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "kind-devops-project-cluster"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "kind-devops-project-cluster"
  }
}

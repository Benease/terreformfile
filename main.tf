provider "kubernetes" {
  config_context_cluster   = "default"  # Specify the name of your Kubernetes cluster context
}

provider "helm" {
  kubernetes {
    config_context_cluster = "default"  # Specify the name of your Kubernetes cluster context
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "3.19.0"

  namespace = "argocd"

  set {
    name  = "server.service.type"
    value = "ClusterIP"  # Change this to NodePort or ClusterIP based on your setup
  }

  # Optionally, you can set more values here using additional set blocks
}

# Output the ArgoCD UI URL after deployment
output "argocd_url" {
  value = helm_release.argocd.metadata.0.name
}


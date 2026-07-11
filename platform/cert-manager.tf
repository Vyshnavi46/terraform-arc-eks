resource "helm_release" "cert_manager" {

  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  namespace        = "cert-manager"
  create_namespace = true

  version = "v1.18.2"

  values = [
    yamlencode({
      crds = {
        enabled = true
      }
    })
  ]

  timeout = 900
  wait    = true
  atomic  = true
}
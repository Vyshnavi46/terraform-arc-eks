resource "helm_release" "arc" {

  name = "gha-runner-scale-set-controller"

  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"

  chart = "gha-runner-scale-set-controller"

  namespace = "arc-system"

  create_namespace = true

  depends_on = [
    helm_release.cert_manager
  ]

}
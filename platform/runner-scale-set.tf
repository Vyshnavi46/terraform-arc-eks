resource "helm_release" "runner" {

  name = "arc-runner"

  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"

  chart = "gha-runner-scale-set"

  namespace = "arc-runners"

  create_namespace = true

  values = [
    file("${path.module}/values/runner.yaml")
  ]

  depends_on = [
    helm_release.arc
  ]

  timeout = 900
  wait    = true
}
{ options, config, lib, pkgs, ... }:

with lib;
with lib.rwaltr;
let cfg = config.rwaltr.tools.k8s;
in
{
  options.rwaltr.tools.k8s = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common Kubernetes utilities.";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      argocd
      dive
      gh
      gojq
      helmfile
      k9s
      krew
      kubecolor
      kubectl
      kubectl-tree
      kubectx
      kubelogic-oidc
      kubernetes-helm
      kubevirt
      kubie
      kustomize
      minikube
      stern
      talos
      yq
    ];
  };
}

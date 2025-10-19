if type -q kubectl
    # kubectl convenience abbreviations
    ## base
    if type -q kubecolor
        abbr -a kubectl kubecolor
    end
    abbr -a k kubectl

    # kubectl krew plugins kubens and kubectx
    abbr -a kctx "kubectl ctx"
    abbr -a kns "kubectl ns"

    ## attach
    abbr -a katt "kubectl attach"
    abbr -a katti "kubectl attach --stdin --tty"

    ## apply
    abbr -a ka "kubectl apply"
    abbr -a kaf "kubectl apply -f"
    abbr -a kafr "kubectl apply --recursive -f"

    ## edit
    abbr -a ke "kubectl edit"
    abbr -a kecm "kubectl edit configmaps"
    abbr -a kecrd "kubectl edit customresourcedefitions"
    abbr -a keds "kubectl edit daemonsets"
    abbr -a ked "kubectl edit deployments"
    abbr -a kehpa "kubectl edit horizontalpodautoscalers"
    abbr -a kei "kubectl edit ingress"
    abbr -a kej "kubectl edit jobs"
    abbr -a kens "kubectl edit namespaces"
    abbr -a ken "kubectl edit nodes"
    abbr -a kepvc "kubectl edit persistentvolumeclaims"
    abbr -a kepv "kubectl edit persistentvolumes"
    abbr -a kep "kubectl edit pods"
    abbr -a kers "kubectl edit replicasets"
    abbr -a kerb "kubectl edit rolebindings"
    abbr -a ker "kubectl edit roles"
    abbr -a kes "kubectl edit secrets"
    abbr -a kesa "kubectl edit serviceaccounts"
    abbr -a kesvc "kubectl edit services"
    abbr -a kess "kubectl edit statefulsets"
    abbr -a kesc "kubectl edit storageclasses"
    abbr -a keva "kubectl edit volumeattachments"
    abbr -a kewli "kubectl edit workloadimages"

    ## delete
    ### Example `kdeld kfgp {deployment name}`
    abbr -a kdel "kubectl delete"
    abbr -a kdelcm "kubectl delete configmaps"
    abbr -a kdelcrd "kubectl delete customresourcedefitions"
    abbr -a kdelds "kubectl delete daemonsets"
    abbr -a kdeld "kubectl delete deployments"
    abbr -a kdelhpa "kubectl delete horizontalpodautoscalers"
    abbr -a kdeli "kubectl delete ingress"
    abbr -a kdelj "kubectl delete jobs"
    abbr -a kdelns "kubectl delete namespaces"
    abbr -a kdeln "kubectl delete nodes"
    abbr -a kdelpvc "kubectl delete persistentvolumeclaims"
    abbr -a kdelpv "kubectl delete persistentvolumes"
    abbr -a kdelp "kubectl delete pods"
    abbr -a kdelrs "kubectl delete replicasets"
    abbr -a kdelrb "kubectl delete rolebindings"
    abbr -a kdelr "kubectl delete roles"
    abbr -a kdels "kubectl delete secrets"
    abbr -a kdelsa "kubectl delete serviceaccounts"
    abbr -a kdelsvc "kubectl delete services"
    abbr -a kdelss "kubectl delete statefulsets"
    abbr -a kdelsc "kubectl delete storageclasses"
    abbr -a kdelva "kubectl delete volumeattachments"
    abbr -a kdelwli "kubectl delete workloadimages"

    ## describe
    abbr -a kd "kubectl describe"
    abbr -a kdcm "kubectl describe configmaps"
    abbr -a kdcrd "kubectl describe customresourcedefinitions"
    abbr -a kdds "kubectl describe daemonsets"
    abbr -a kdd "kubectl describe deployments"
    abbr -a kdhpa "kubectl describe horizontalpodautoscalers"
    abbr -a kdi "kubectl describe ingress"
    abbr -a kdj "kubectl describe jobs"
    abbr -a kdns "kubectl describe namespaces"
    abbr -a kdn "kubectl describe nodes"
    abbr -a kdpvc "kubectl describe persistentvolumeclaims"
    abbr -a kdpv "kubectl describe persistentvolumes"
    abbr -a kdp "kubectl describe pods"
    abbr -a kdrs "kubectl describe replicasets"
    abbr -a kdrb "kubectl describe rolebindings"
    abbr -a kdr "kubectl describe roles"
    abbr -a kds "kubectl describe secrets"
    abbr -a kdsa "kubectl describe serviceaccounts"
    abbr -a kdsvc "kubectl describe services"
    abbr -a kdss "kubectl describe statefulsets"
    abbr -a kdsc "kubectl describe storageclasses"
    abbr -a kdva "kubectl describe volumeattachments"
    abbr -a kdwli "kubectl describe workloadimages"

    ## get
    abbr -a kg "kubectl get"
    abbr -a kgcm "kubectl get configmaps"
    abbr -a kgcrd "kubectl get customresourcedefinitions"
    abbr -a kgds "kubectl get daemonsets"
    abbr -a kgd "kubectl get deployments"
    abbr -a kghpa "kubectl get horizontalpodautoscalers"
    abbr -a kgi "kubectl get ingress"
    abbr -a kgj "kubectl get jobs"
    abbr -a kgns "kubectl get namespaces"
    abbr -a kgn "kubectl get nodes"
    abbr -a kgpvc "kubectl get persistentvolumeclaims"
    abbr -a kgpv "kubectl get persistentvolumes"
    abbr -a kgp "kubectl get pods"
    abbr -a kgrs "kubectl get replicasets"
    abbr -a kgrb "kubectl get rolebindings"
    abbr -a kgr "kubectl get roles"
    abbr -a kgs "kubectl get secrets"
    abbr -a kgsa "kubectl get serviceaccounts"
    abbr -a kgsvc "kubectl get services"
    abbr -a kgss "kubectl get statefulsets"
    abbr -a kgsc "kubectl get storageclasses"
    abbr -a kgva "kubectl get volumeattachments"
    abbr -a kgwli "kubectl get workloadimages"

    ## logs
    abbr -a kl "kubectl logs"
    abbr -a klf "kubectl logs --follow"
    abbr -a klfa "kubectl logs --follow --all-containers"
    abbr -a klft "kubectl logs --follow --tail 50"
    abbr -a klfta "kubectl logs --follow --tail 50 --all-containers"
    abbr -a klp "kubectl logs --previous"
    abbr -a klpa "kubectl logs --previous --all-containers"
    abbr -a klpt "kubectl logs --previous --tail 50"
    abbr -a klpta "kubectl logs --previous --tail 50 --all-containers"

    ## patch
    abbr -a kpch "kubectl patch"
    abbr -a kpchcm "kubectl patch configmaps"
    abbr -a kpchcrd "kubectl patch customresourcedefitions"
    abbr -a kpchds "kubectl patch daemonsets"
    abbr -a kpchd "kubectl patch deployments"
    abbr -a kpchhpa "kubectl patch horizontalpodautoscalers"
    abbr -a kpi "kubectl patch ingress"
    abbr -a kpchj "kubectl patch jobs"
    abbr -a kpchns "kubectl patch namespaces"
    abbr -a kpchn "kubectl patch nodes"
    abbr -a kpchpvc "kubectl patch persistentvolumeclaims"
    abbr -a kpchpv "kubectl patch persistentvolumes"
    abbr -a kpchp "kubectl patch pods"
    abbr -a kpchrs "kubectl patch replicasets"
    abbr -a kpchrb "kubectl patch rolebindings"
    abbr -a kpchr "kubectl patch roles"
    abbr -a kpchs "kubectl patch secrets"
    abbr -a kpchsa "kubectl patch serviceaccounts"
    abbr -a kpchsvc "kubectl patch services"
    abbr -a kpchss "kubectl patch statefulsets"
    abbr -a kpchsc "kubectl patch storageclasses"
    abbr -a kpchva "kubectl patch volumeattachments"
    abbr -a kpchwli "kubectl patch workloadimages"

    ## create
    abbr -a kcs "kubectl create secret"
    abbr -a kcsg "kubectl create secret generic"
    ## port-forward
    abbr -a kpf "kubectl port-forward"
    abbr -a kpfa "kubectl port-forward --address"

    ## run
    abbr -a kr "kubectl run"
    abbr -a krhelp "echo kr POD_NAME --env=/--expose/--image=/--port=/--restart=/--rm/--stdin/--tty -- [COMMAND] [ARGS]"
    abbr -a kdebug "kubectl run debug --image=fedora:42 --restart=Never --rm --stdin --tty -- bash"

    ## extras
    abbr -a kdiff "kubectl diff -f"
    abbr -a kex "kubectl exec -it"
    abbr -a kexw "kubectl exec -it --pod-running-timeout=1m"

    ## krew addons
    abbr -a kvs "kubectl view-secret"
    abbr -a kvsa "kubectl view-secret -a"

    ## kubectl
    abbr -a kctx kubectx
    abbr -a kns kubens
end

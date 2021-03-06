# kubectl convenience aliases
## base
alias k="kubectl"
complete -F _complete_alias k

## attach
alias katt="kubectl attach"
complete -F _complete_alias katt
alias katti="kubectl attach --stdin --tty"
complete -F _complete_alias katti

## apply
alias ka="kubectl apply"
complete -F _complete_alias ka
alias kaf="kubectl apply -f"
complete -F _complete_alias kaf
alias kafr="kubectl apply --recursive -f"
complete -F _complete_alias kafr

## edit
alias ke="kubectl edit"
complete -F _complete_alias ke
alias kecm="kubectl edit configmaps"
complete -F _complete_alias kecm
alias kecrd="kubectl edit customresourcedefitions"
complete -F _complete_alias kecrd
alias keds="kubectl edit daemonsets"
complete -F _complete_alias keds
alias ked="kubectl edit deployments"
complete -F _complete_alias ked
alias kehpa="kubectl edit horizontalpodautoscalers"
complete -F _complete_alias kehpa
alias kei="kubectl edit ingress"
complete -F _complete_alias kei
alias kej="kubectl edit jobs"
complete -F _complete_alias kej
alias kens="kubectl edit namespaces"
complete -F _complete_alias kens
alias ken="kubectl edit nodes"
complete -F _complete_alias ken
alias kepvc="kubectl edit persistentvolumeclaims"
complete -F _complete_alias kepvc
alias kepv="kubectl edit persistentvolumes"
complete -F _complete_alias kepv
alias kep="kubectl edit pods"
complete -F _complete_alias kep
alias kers="kubectl edit replicasets"
complete -F _complete_alias kers
alias kerb="kubectl edit rolebindings"
complete -F _complete_alias kerb
alias ker="kubectl edit roles"
complete -F _complete_alias ker
alias kes="kubectl edit secrets"
complete -F _complete_alias kes
alias kesa="kubectl edit serviceaccounts"
complete -F _complete_alias kesa
alias kesvc="kubectl edit services"
complete -F _complete_alias kesvc
alias kess="kubectl edit statefulsets"
complete -F _complete_alias kess
alias kesc="kubectl edit storageclasses"
complete -F _complete_alias kesc
alias keva="kubectl edit volumeattachments"
complete -F _complete_alias keva
alias kewli="kubectl edit workloadimages"
complete -F _complete_alias kewli

## delete
### Example `kdeld kfgp {deployment name}`
alias kfgp="--force --grace-period=0"
complete -F _complete_alias kfgp
alias kdel="kubectl delete"
complete -F _complete_alias kdel
alias kdelcm="kubectl delete configmaps"
complete -F _complete_alias kdelcm
alias kdelcrd="kubectl delete customresourcedefitions"
complete -F _complete_alias kdelcrd
alias kdelds="kubectl delete daemonsets"
complete -F _complete_alias kdelds
alias kdeld="kubectl delete deployments"
complete -F _complete_alias kdeld
alias kdelhpa="kubectl delete horizontalpodautoscalers"
complete -F _complete_alias kdelhpa
alias kdeli="kubectl delete ingress"
complete -F _complete_alias kdeli
alias kdelj="kubectl delete jobs"
complete -F _complete_alias kdelj
alias kdelns="kubectl delete namespaces"
complete -F _complete_alias kdelns
alias kdeln="kubectl delete nodes"
complete -F _complete_alias kdeln
alias kdelpvc="kubectl delete persistentvolumeclaims"
complete -F _complete_alias kdelpvc
alias kdelpv="kubectl delete persistentvolumes"
complete -F _complete_alias kdelpv
alias kdelp="kubectl delete pods"
complete -F _complete_alias kdelp
alias kdelrs="kubectl delete replicasets"
complete -F _complete_alias kdelrs
alias kdelrb="kubectl delete rolebindings"
complete -F _complete_alias kdelrb
alias kdelr="kubectl delete roles"
complete -F _complete_alias kdelr
alias kdels="kubectl delete secrets"
complete -F _complete_alias kdels
alias kdelsa="kubectl delete serviceaccounts"
complete -F _complete_alias kdelsa
alias kdelsvc="kubectl delete services"
complete -F _complete_alias kdelsvc
alias kdelss="kubectl delete statefulsets"
complete -F _complete_alias kdelss
alias kdelsc="kubectl delete storageclasses"
complete -F _complete_alias kdelsc
alias kdelva="kubectl delete volumeattachments"
complete -F _complete_alias kdelva
alias kdelwli="kubectl delete workloadimages"
complete -F _complete_alias kdelwli

## describe
alias kd="kubectl describe"
complete -F _complete_alias kd
alias kdcm="kubectl describe configmaps"
complete -F _complete_alias kdcm
alias kdcrd="kubectl describe customresourcedefinitions"
complete -F _complete_alias kdcrd
alias kdds="kubectl describe daemonsets"
complete -F _complete_alias kdds
alias kdd="kubectl describe deployments"
complete -F _complete_alias kdd
alias kdhpa="kubectl describe horizontalpodautoscalers"
complete -F _complete_alias kdhpa
alias kdi="kubectl describe ingress"
complete -F _complete_alias kdi
alias kdj="kubectl describe jobs"
complete -F _complete_alias kdj
alias kdns="kubectl describe namespaces"
complete -F _complete_alias kdns
alias kdn="kubectl describe nodes"
complete -F _complete_alias kdn
alias kdpvc="kubectl describe persistentvolumeclaims"
complete -F _complete_alias kdpvc
alias kdpv="kubectl describe persistentvolumes"
complete -F _complete_alias kdpv
alias kdp="kubectl describe pods"
complete -F _complete_alias kdp
alias kdrs="kubectl describe replicasets"
complete -F _complete_alias kdrs
alias kdrb="kubectl describe rolebindings"
complete -F _complete_alias kdrb
alias kdr="kubectl describe roles"
complete -F _complete_alias kdr
alias kds="kubectl describe secrets"
complete -F _complete_alias kds
alias kdsa="kubectl describe serviceaccounts"
complete -F _complete_alias kdsa
alias kdsvc="kubectl describe services"
complete -F _complete_alias kdsvc
alias kdss="kubectl describe statefulsets"
complete -F _complete_alias kdss
alias kdsc="kubectl describe storageclasses"
complete -F _complete_alias kdsc
alias kdva="kubectl describe volumeattachments"
complete -F _complete_alias kdva
alias kdwli="kubectl describe workloadimages"
complete -F _complete_alias kdwli

## get
alias kg="kubectl get"
complete -F _complete_alias kg
alias kgcm="kubectl get configmaps"
complete -F _complete_alias kgcm
alias kgcrd="kubectl get customresourcedefinitions"
complete -F _complete_alias kgcrd
alias kgds="kubectl get daemonsets"
complete -F _complete_alias kgds
alias kgd="kubectl get deployments"
complete -F _complete_alias kgd
alias kghpa="kubectl get horizontalpodautoscalers"
complete -F _complete_alias kghpa
alias kgi="kubectl get ingress"
complete -F _complete_alias kgi
alias kgj="kubectl get jobs"
complete -F _complete_alias kgj
alias kgns="kubectl get namespaces"
complete -F _complete_alias kgns
alias kgn="kubectl get nodes"
complete -F _complete_alias kgn
alias kgpvc="kubectl get persistentvolumeclaims"
complete -F _complete_alias kgpvc
alias kgpv="kubectl get persistentvolumes"
complete -F _complete_alias kgpv
alias kgp="kubectl get pods"
complete -F _complete_alias kgp
alias kgrs="kubectl get replicasets"
complete -F _complete_alias kgrs
alias kgrb="kubectl get rolebindings"
complete -F _complete_alias kgrb
alias kgr="kubectl get roles"
complete -F _complete_alias kgr
alias kgs="kubectl get secrets"
complete -F _complete_alias kgs
alias kgsa="kubectl get serviceaccounts"
complete -F _complete_alias kgsa
alias kgsvc="kubectl get services"
complete -F _complete_alias kgsvc
alias kgss="kubectl get statefulsets"
complete -F _complete_alias kgss
alias kgsc="kubectl get storageclasses"
complete -F _complete_alias kgsc
alias kgva="kubectl get volumeattachments"
complete -F _complete_alias kgva
alias kgwli="kubectl get workloadimages"
complete -F _complete_alias kgwli

## logs
alias kl="kubectl logs"
complete -F _complete_alias kl
alias klf="kubectl logs --follow"
complete -F _complete_alias klf
alias klfa="kubectl logs --follow --all-containers"
complete -F _complete_alias klfa
alias klft="kubectl logs --follow --tail 50"
complete -F _complete_alias klft
alias klfta="kubectl logs --follow --tail 50 --all-containers"
complete -F _complete_alias klfta
alias klp="kubectl logs --previous"
complete -F _complete_alias klp
alias klpa="kubectl logs --previous --all-containers"
complete -F _complete_alias klpa
alias klpt="kubectl logs --previous --tail 50"
complete -F _complete_alias klpt
alias klpta="kubectl logs --previous --tail 50 --all-containers"
complete -F _complete_alias klpta

## patch
alias kpch="kubectl patch"
complete -F _complete_alias kpch
alias kpchcm="kubectl patch configmaps"
complete -F _complete_alias kpchcm
alias kpchcrd="kubectl patch customresourcedefitions"
complete -F _complete_alias kpchcrd
alias kpchds="kubectl patch daemonsets"
complete -F _complete_alias kpchds
alias kpchd="kubectl patch deployments"
complete -F _complete_alias kpchd
alias kpchhpa="kubectl patch horizontalpodautoscalers"
complete -F _complete_alias kpchhpa
alias kpi="kubectl patch ingress"
complete -F _complete_alias kpi
alias kpchj="kubectl patch jobs"
complete -F _complete_alias kpchj
alias kpchns="kubectl patch namespaces"
complete -F _complete_alias kpchns
alias kpchn="kubectl patch nodes"
complete -F _complete_alias kpchn
alias kpchpvc="kubectl patch persistentvolumeclaims"
complete -F _complete_alias kpchpvc
alias kpchpv="kubectl patch persistentvolumes"
complete -F _complete_alias kpchpv
alias kpchp="kubectl patch pods"
complete -F _complete_alias kpchp
alias kpchrs="kubectl patch replicasets"
complete -F _complete_alias kpchrs
alias kpchrb="kubectl patch rolebindings"
complete -F _complete_alias kpchrb
alias kpchr="kubectl patch roles"
complete -F _complete_alias kpchr
alias kpchs="kubectl patch secrets"
complete -F _complete_alias kpchs
alias kpchsa="kubectl patch serviceaccounts"
complete -F _complete_alias kpchsa
alias kpchsvc="kubectl patch services"
complete -F _complete_alias kpchsvc
alias kpchss="kubectl patch statefulsets"
complete -F _complete_alias kpchss
alias kpchsc="kubectl patch storageclasses"
complete -F _complete_alias kpchsc
alias kpchva="kubectl patch volumeattachments"
complete -F _complete_alias kpchva
alias kpchwli="kubectl patch workloadimages"
complete -F _complete_alias kpchwli

## create
alias kcs="kubectl create secret"
complete -F _complete_alias kcs
alias kcsg="kubectl create secret generic"
complete -F _complete_alias kcsg
## port-forward
alias kpf="kubectl port-forward"
complete -F _complete_alias kpf
alias kpfa="kubectl port-forward --address"
complete -F _complete_alias kpfa

## run
alias kr="kubectl run"
complete -F _complete_alias kr
alias krhelp="echo kr POD_NAME --env=/--expose/--image=/--port=/--restart=/--rm/--stdin/--tty -- [COMMAND] [ARGS]"
alias krdebug="kubectl run debug --image=ubuntu:focal --restart=Never --rm --stdin --tty -- bash"

## extras
alias kdiff="kubectl diff -f"
complete -F _complete_alias kdiff
alias kex="kubectl exec -it"
complete -F _complete_alias kex
alias kexw="kubectl exec -it --pod-running-timeout=1m"
complete -F _complete_alias kexw

## krew addons
alias kvs="kubectl view-secret"
complete -F _complete_alias kvs
alias kvsa="kubectl view-secret -a"
complete -F _complete_alias kvsa
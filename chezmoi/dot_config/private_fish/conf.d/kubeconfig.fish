# default kubeconfig
set FILES "$HOME/.kube/config"

# create clusters directory if its not created
set CLUSTERS_DIR "$HOME/.kube/clusters"
mkdir -p "$CLUSTERS_DIR"
test CLUSTERS_DIR

for cluster in (find $CLUSTERS_DIR -type f -name "*.yml")
    set FILES "$cluster:$FILES"
end

for cluster in (find $CLUSTERS_DIR -type f -name "*.yaml")
    set FILES "$cluster:$FILES"
end


set -gx KUBECONFIG $FILES

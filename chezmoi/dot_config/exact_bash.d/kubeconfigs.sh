# default kubeconfig
FILES="$HOME/.kube/config"

# create clusters directory if its not created
CLUSTERS_DIR="$HOME/.kube/clusters"
mkdir -p "$CLUSTERS_DIR"
test CLUSTERS_DIR

for cluster in `find $CLUSTERS_DIR -type f -name "*.yml"`
do
  FILES="$cluster:$FILES"
done

for cluster in `find $CLUSTERS_DIR -type f -name "*.yaml"`
do
  FILES="$cluster:$FILES"
done


export KUBECONFIG=$FILES

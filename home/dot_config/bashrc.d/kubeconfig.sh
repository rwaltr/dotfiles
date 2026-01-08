# Kubeconfig management functions

# sets kubeconfig env with .kube/clusters
set-kubeconfig() {
    local FILES=""
    
    # default kubeconfig
    if [ -f "$HOME/.kube/config" ]; then
        FILES="$HOME/.kube/config"
    fi
    
    # create clusters directory if it doesn't exist
    local CLUSTERS_DIR="$HOME/.kube/clusters"
    mkdir -p "$CLUSTERS_DIR"
    
    # Find all yaml/yml files in clusters directory
    shopt -s nullglob
    for cluster in "$CLUSTERS_DIR"/*.yml "$CLUSTERS_DIR"/*.yaml; do
        if [ -f "$cluster" ]; then
            FILES="$cluster:$FILES"
        fi
    done
    shopt -u nullglob
    
    # Remove trailing colon
    FILES="${FILES%:}"
    
    # Set KUBECONFIG environment variable
    if [ -n "$FILES" ]; then
        export KUBECONFIG="$FILES"
    fi
}

# unsets kubeconfig env
unset-kubeconfig() {
    unset KUBECONFIG
}

# isolate kubeconfig for session
isolate-kubeconfig() {
    export KUBECONFIG="$1"
}

# append kubeconfig for session
append-kubeconfig() {
    export KUBECONFIG="$KUBECONFIG:$1"
}

# store kubeconfig in .kube/clusters
store-kubeconfig() {
    local config_path="$1"
    local basename=$(basename "$config_path")
    cp "$config_path" "$HOME/.kube/clusters/$basename"
    set-kubeconfig
}

# Initialize kubeconfig if kubectl is available
if command -v kubectl &> /dev/null; then
    set-kubeconfig
fi

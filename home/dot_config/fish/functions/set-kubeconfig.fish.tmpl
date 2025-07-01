function set-kubeconfig --description 'sets kubeconfig env with .kube/clusters'

    # Init var
    set FILES ""
    # default kubeconfig
    if test -f $HOME/.kube/config
        set FILES "$HOME/.kube/config"
    end
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
    set FILES (string trim -r -c ':' $FILES)
    set -gx KUBECONFIG $FILES

end

function unset-kubeconfig --description 'unsets kubeconfig env'
    set -e KUBECONFIG
end

function isolate-kubeconfig --description 'isolate kubeconfig for session'
    set -gx KUBECONFIG $argv[1]
end

function append-kubeconfig --description 'append kubeconfig for session'
    set -gx KUBECONFIG "$KUBECONFIG:$argv[1]"
end

function store-kubeconfig --description 'store kubeconfig in .kube/clusters'
    cp $argv[1] $HOME/.kube/clusters/$argv[1]
    set-kubeconfig
end

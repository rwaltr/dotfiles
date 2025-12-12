# Kubeconfig management functions

# sets kubeconfig env with .kube/clusters
export def set-kubeconfig [] {
    mut files = []
    
    # default kubeconfig
    let default_config = ($env.HOME | path join ".kube" "config")
    if ($default_config | path exists) {
        $files = ($files | append $default_config)
    }
    
    # create clusters directory if it doesn't exist
    let clusters_dir = ($env.HOME | path join ".kube" "clusters")
    mkdir $clusters_dir
    
    # Find all yaml/yml files in clusters directory
    let cluster_files = (
        try {
            ls $"($clusters_dir)/*.{yml,yaml}" -s | get name
        } catch {
            []
        }
    )
    
    $files = ($files | append $cluster_files)
    
    # Set KUBECONFIG environment variable
    if ($files | is-not-empty) {
        $env.KUBECONFIG = ($files | str join ":")
    }
}

# unsets kubeconfig env
export def unset-kubeconfig [] {
    hide-env KUBECONFIG
}

# isolate kubeconfig for session
export def isolate-kubeconfig [config_path: string] {
    $env.KUBECONFIG = $config_path
}

# append kubeconfig for session
export def append-kubeconfig [config_path: string] {
    $env.KUBECONFIG = $"($env.KUBECONFIG):($config_path)"
}

# store kubeconfig in .kube/clusters
export def store-kubeconfig [config_path: string] {
    let dest = ($env.HOME | path join ".kube" "clusters" ($config_path | path basename))
    cp $config_path $dest
    set-kubeconfig
}

# cdtdir - cd to a new temp directory
export def cdtdir [] {
    cd (mktemp -d | str trim)
}

# Initialize kubeconfig if kubectl is available
if (which kubectl | is-not-empty) {
    set-kubeconfig
}

nix-check-upgrades-better () 
{ 
    if [[ $# -eq 0 ]]; then
        echo "ERROR: must be called with path.";
        echo "       e.g.";
        echo "${FUNCNAME[0]} "'$(pwd)';
        return 1;
    fi;
    if [[ ! -n $(command -v nvd) ]]; then
        echo "This function requires nvd to be installed";
        echo 'You can install it temporarily with `nix-shell -p nvd`';
    fi;
    local flakes_params='';
    local flakes_path="$1";
    local flakes='True';
    local tempdir="$flakes_path";
    flakes_params='--flake .#';
    tempdir=$(echo "$tempdir" | perl -plane 's|^(.*)/$|\1|');
    pushd "$tempdir" &> /dev/null;
    if [[ -L "$tempdir/result" ]]; then
        rm "$tempdir/result";
    fi;
    eval time sudo nixos-rebuild build "$flakes_params";
    nvd diff /run/current-system "$tempdir/result";
    popd &> /dev/null
}

time nix-check-upgrades-better "$@"

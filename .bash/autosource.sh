#!/usr/bin/env bash

# function to load source file based on current directory
# if we are /home/user the loaded script will be
# ~/autosource/home/user.sh
# note: it is not possible to use it for the root directory
function autosource_hook() {
    local sourcefile="${HOME}/autosource${PWD}.sh"
    # flag to prevent infinite recursion when source file spawns a new shell
    local flag="$(echo -n autosource$sourcefile | tr -c '[:alnum:]' '[_*]')"
    if [[ -z "${!flag}" && -f "$sourcefile" ]]; then
        declare "$flag=1"
        export "$flag"
        source $sourcefile
    fi
}

#!/usr/bin/env bash

set -euo pipefail

function err() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z') line:${BASH_LINENO[0]}]: $*" >&2
    exit 1
}

function main() {
    (( "$#" >= 2 )) && err "too many args count: $#"
    declare -r name=$1
    echo "Hello, ${name:-world}!"
}

[[ "${BASH_SOURCE[0]}" == "$0" ]] && main "$@"

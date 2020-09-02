#!/usr/bin/env import

set -euo pipefail

import "https://raw.githubusercontent.com/watarukura/bash_vscode_project_template/master/functions.bash"

function main() {
    (( "$#" >= 2 )) && err "too many args count: $#"
    declare -r name=$1
    echo "Hello, ${name:-world}!"
}

# sourceから読み込まれた場合は実行しない
[[ "${BASH_SOURCE[0]}" == "$0" ]] && main "$@"

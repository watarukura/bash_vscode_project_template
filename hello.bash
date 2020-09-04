#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source /usr/local/bin/import

import "https://raw.githubusercontent.com/watarukura/bash_vscode_project_template/master/functions.bash"

function main() {
    (("$#" >= 2)) && err "too many args count: $#"
    [[ "$#" == 1 ]] && declare -r name=$1
    echo "Hello, ${name:-world}!" > ${tmp_dir}/hello
}

# sourceから読み込まれた場合は実行しない
[[ "${BASH_SOURCE[0]}" == "$0" ]] && main "$@"

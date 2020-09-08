#!/usr/bin/env bash

set -euo pipefail

source ./constants.bash

# shellcheck disable=SC1091
# source /usr/local/bin/import
# import "https://raw.githubusercontent.com/watarukura/bash_vscode_project_template/master/functions.bash"
# debug用
source ./functions.bash

function main() {
    logging "start"
    (("$#" >= 2)) && error_exit "too many args count: expect \"0-1\", actual $#"
    [[ "$#" == 1 ]] && declare -r name=$1
    logging "Hello, ${name:-world}!"
    logging "end"
}

# sourceから読み込まれた場合は実行しない
[[ "${BASH_SOURCE[0]}" == "$0" ]] && main "$@"

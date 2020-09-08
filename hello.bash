#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source /usr/local/bin/import
import "https://raw.githubusercontent.com/watarukura/bash_vscode_project_template/master/functions.bash"
# debug用
# source ./functions.bash
# shellcheck disable=SC2034,SC2155
declare -r tmp_dir="$(tempdir)"

function main() {
    logger_info "start"
    (("$#" >= 2)) && error_exit "too many args count: expect \"0-1\", actual $#"
    [[ "$#" == 1 ]] && declare -r name=$1
    logger_info "Hello, ${name:-world}!"
    logger_info "end"
}

# sourceから読み込まれた場合は実行しない
[[ "${BASH_SOURCE[0]}" == "$0" ]] && main "$@"

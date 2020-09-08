function error_exit() {
    _log_level="ERROR" _log_line=${BASH_LINENO[0]} logger "$@"
    
    # shellcheck disable=SC2155
    declare -r log_dir=$(pwd)/log
    mv "${tmp_dir}" "${log_dir}"
    exit 1
}

function normal_exit() {
    rm -rf ${tmp_dir}/
    exit 0
}

function logger() {
    # shellcheck disable=SC2155
    declare -r date=$(date +'%Y-%m-%dT%H:%M:%S%z')
    declare -r line=${_log_line:-${BASH_LINENO[0]}}
    declare -r level=${_log_level:-"INFO"}
    # shellcheck disable=SC2001,SC2155
    declare -r message=$(echo "$*" | sed -e 's/"/\\"/g')
    # shellcheck disable=SC2086,SC2155
    declare -r log_file="$(pwd)/log/$(basename ${0}).jsonl"
    
    cat <<EOF | tee -a ${log_file}
{"date":"${date}","line":${line},"level":"${level}","message":"${message}"}
EOF
}

function logger_info() {
    _log_level="INFO" _log_line=${BASH_LINENO[0]} logger "$@"
}

function tempdir() {
    # shellcheck disable=SC2086
    mktemp -d "$(basename ${0}).$(date '+%Y%m%d%H%M%S').XXXXXX"
}

# エラー終了
trap 'error_exit "強制終了"' 1 2 3 15
function error_exit() {
    _log_level="ERROR" _log_line=${BASH_LINENO[0]} logger "$@"
    
    declare -r log_dir
    log_dir=$(pwd)/log
    mv "${tmp_dir}" "${log_dir}"
    exit 1
}

function logger() {
    declare -r date
    date=$(date +'%Y-%m-%dT%H:%M:%S%z')
    declare -r line=${_log_line:-${BASH_LINENO[0]}}
    declare -r level=${_log_level:-"INFO"}
    declare -r message
    # shellcheck disable=SC2001
    message=$(echo "$*" | sed -e 's/"/\\"/g')
    declare -r log_file
    log_file="$(pwd)/log/$(basename ${0}).jsonl"
    
    cat <<EOF | tee -a ${log_file}
{"date":"${date}","line":${line},"level":"${level}","message":"${message}"}
EOF
}

function logger_info() {
    _log_level="INFO" _log_line=${BASH_LINENO[0]} logger "$@"
}

function tempdir() {
    mktemp -d "$(basename ${0})"."$(date '+%Y%m%d%H%M%S')"."XXXXXX"
}

# エラー終了
trap 'error_exit "強制終了"' 1 2 3 15
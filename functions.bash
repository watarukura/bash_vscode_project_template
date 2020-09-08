function error_exit() {
    declare -r tmp_dir=${tmp_dir}
    declare -r log_dir=$(pwd)/log
    declare -r now=$(date '+%Y%m%d%H%M%S')
    
    _log_level="ERROR" _log_line=${BASH_LINENO[0]} logging "$@"
    
    mv "${tmp_dir}" "${log_dir}"
    cd "${log_dir}" && mv $(basename "${tmp_dir}") "$(basename ${0}).${now}.$$"
    exit 1
}

function logging() {
    declare -r date=$(date +'%Y-%m-%dT%H:%M:%S%z')
    declare -r line=${_log_line:-${BASH_LINENO[0]}}
    declare -r level=${_log_level:-"INFO"}
    declare -r message=${@//"/\\"/}
    declare -r log_file="$(pwd)/log/$(basename ${0}).jsonl"
    cat <<EOF | tee -a ${log_file}
{"date":"${date}","line":${line},"level":"${level}","message":"${message}"}
EOF
}

# エラー終了
trap 'error_exit "強制終了"' 1 2 3 15
function error_exit() {
    _log_level="ERROR" _log_line=${BASH_LINENO[0]} logging "$@"
    mv "${tmp_dir}" "${log_dir}"
    cd ${log_dir} && mv $(basename ${tmp_dir}) $(basename ${0}).${now}.$$ || exit 1
}

function logging() {
    declare -r date=$(date +${now_log})
    declare -r line=${_log_line:-${BASH_LINENO[0]}}
    declare -r level=${_log_level:-"INFO"}
    declare -r message=$(echo $* | sed -e 's/"/\\"/g')
    cat <<EOF | tee -a ${log_file}
{"date":"${date}","line":${line},"level":"${level}","message":"${message}"}
EOF
}

# エラー終了
trap 'error_exit "強制終了"' 1 2 3 15
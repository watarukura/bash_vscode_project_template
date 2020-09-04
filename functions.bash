function export_constatn() {
    tmp_dir=$(mktemp -d); export tmp_dir
    log_dir=./log; export log_dir
}

function error_exit() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z') line:${BASH_LINENO[0]}]: $*" >&2
    mv "${tmp_dir}" "${log_dir}"/
    exit 1
}

function normal_exit() {
    exit 0
}

# エラー終了
trap error_exit ERR

# 正常終了
trap normal_exit EXIT

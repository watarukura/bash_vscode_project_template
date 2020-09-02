function err() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z') line:${BASH_LINENO[0]}]: $*" >&2
    exit 1
}

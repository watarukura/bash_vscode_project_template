#######################################
# Exit with Error
# Globals:
#   TMP_DIR
# Arguments:
#   Any
# Returns:
#   1
#######################################
function error_exit() {
    _log_level="ERROR" _log_line=${BASH_LINENO[0]} _logger "$@"
    
    # shellcheck disable=SC2155
    declare -r log_dir=$(pwd)/log
    mv "${TMP_DIR}" "${log_dir}"
    exit 1
}

#######################################
# Exit with Remove Temporary Direcotry
# Globals:
#   TMP_DIR
# Arguments:
#   Any
# Returns:
#   0
#######################################
function normal_exit() {
    rm -rf "${TMP_DIR}"
    exit 0
}

#######################################
# Logger
# Globals:
#   None
# Arguments:
#   Any
# Outputs:
#   Write JSON format Log to STDOUT
#######################################
function _logger() {
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

#######################################
# Call Logger with log level INFO
# Globals:
#   None
# Arguments:
#   Any
# Returns:
#   None
#######################################
function logger_info() {
    _log_level="INFO" _log_line=${BASH_LINENO[0]} _logger "$@"
}

#######################################
# Make Temporary Directory
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   Temporary Directory Name to STDOUT
#######################################
function tempdir() {
    # shellcheck disable=SC2086
    mktemp -d "$(basename ${0}).$(date '+%Y%m%d%H%M%S').XXXXXX"
}

# エラー終了
trap 'error_exit "強制終了"' 1 2 3 15

# 正常終了
trap 'normal_exit "正常終了"' 0
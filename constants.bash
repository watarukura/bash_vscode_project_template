declare -r tmp_dir=$(mktemp -d)
declare -r log_dir=$(pwd)/log
declare -r log_file=${log_dir}/$(basename ${0}).jsonl
declare -r now=$(date '+%Y%m%d%H%M%S')
declare -r now_log='%Y-%m-%dT%H:%M:%S%z'
declare -r tmp=${tmp_dir}/$(basename ${0}).${now}.$$

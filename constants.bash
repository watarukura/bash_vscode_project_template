declare -r tmp_dir=$(mktemp -d)
declare -r tmp="${tmp_dir}/$(basename ${0}).$(date '+%Y%m%d%H%M%S').$$"

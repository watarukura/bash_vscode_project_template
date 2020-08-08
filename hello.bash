#!/usr/bin/env bash

set -xv

function main() {
    local name=$1
    echo "Hello, ${name:-world}!"
}

main "$@"

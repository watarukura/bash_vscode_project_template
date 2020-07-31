#!/usr/bin/env bash

set -xv

main() {
    local name=$1
    echo "Hello, ${name:-world}!"
}

main "$@"
#!/usr/bin/env bash -xv

main() {
    local name=$1
    echo "Hello, ${name:-world}!"
}

main ${*}
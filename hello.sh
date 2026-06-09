#!/usr/bin/env bash

set -euo pipefail

NAME="${1:-NO}"
COUNT="${2:-4}"

# Function
greet() {
    local who="$1"           # $1 is the first argument
    echo "Hello, $who!"
}

# Loop
for i in $(seq 1 $COUNT); do
    greet "$NAME #$i"
done
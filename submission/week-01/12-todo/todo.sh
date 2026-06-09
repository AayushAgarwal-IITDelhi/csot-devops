#!/usr/bin/env bash
set -euo pipefail

FILE="${TODO_FILE:-$HOME/.todo}"
CMD="${1:-list}"

[[ $# -gt 0 ]] && shift

case $CMD in
    add)
        ARG="${1:-}"
        shift
        if [[ $# -gt 0 ]]; then 
            echo "Usage <subcommand> [args...]"; exit 2
        fi
        printf "[ ] $ARG\n" >> "$FILE"
        ;;
    list)
        if [[ $# -gt 0 ]]; then 
            echo "Usage <subcommand> [args...]"; exit 2
        fi
        awk '{ print NR ":", $0 }' "$FILE"
        ;;
    done)
        ARG="${1:-}"
        shift
        if [[ $# -gt 0 ]]; then 
            echo "Usage <subcommand> [args...]"; exit 2
        fi
        tmp=$(mktemp)
        sed "${ARG}s/^\[ \]/[x]/" "$FILE" > "$tmp"
        mv "$tmp" "$FILE"
        ;;
    remove)
        ARG="${1:-}"
        shift
        if [[ $# -gt 0 ]]; then 
            echo "Usage <subcommand> [args...]"; exit 2
        fi
        tmp=$(mktemp)
        sed "${ARG}d" "$FILE" > "$tmp"
        mv "$tmp" "$FILE"
        ;;
    *)
        echo "Usage <subcommand> [args...]"
        exit 2
esac
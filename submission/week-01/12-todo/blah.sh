#!/usr/bin/env bash
set -euo pipefail

FILE="$HOME/.todo"
CMD="${1:-}"

shift

ARG="${@:-}"

case $CMD in
    add)
        printf "[ ] $ARG\n" >> "$FILE"
        ;;
    list)
        awk '{ print NR ":", $0 }' "$FILE"
        ;;
    done)
        # sudo sed -i.bak "${ARG}s/^\[ \]/[x]/" "$FILE"
        tmp=$(mktemp)
        sed "${ARG}s/^\[ \]/[x]/" "$FILE" > "$tmp"
        mv "$tmp" "$FILE"
        ;;
    remove)
        #sed -i "${ARG}d" "$FILE"
        tmp=$(mktemp)
        sed "${ARG}d" "$FILE" > "$tmp"
        mv "$tmp" "$FILE"
        ;;
    *)
        echo "Usage <subcommand> [args...]"
        exit 2
esac
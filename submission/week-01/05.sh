#!/usr/bin/env bash

FILE="${1:-}"

cat "$FILE" | jq -r '.users[] | select(.active == true) | .email'
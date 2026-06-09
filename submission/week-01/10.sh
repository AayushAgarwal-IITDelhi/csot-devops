#!/usr/bin/env bash
set -euo pipefail

DIR="$1"

find "$DIR" -type d | xargs du -k | sort -rn | head -10
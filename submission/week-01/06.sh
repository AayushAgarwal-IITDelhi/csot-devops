#!/usr/bin/env bash

max_attempts="${1:-}"
delay="${2:-}"
command="${@:4}"

for i in $(seq 1 $max_attempts); do
    bash -c "$command"
    rc=$?
    [[ "$rc" -eq 0 ]] && break
    [[ "$i" -eq $max_attempts ]] && break
    sleep $delay
    delay=$((delay * 2))
done

exit "$rc"
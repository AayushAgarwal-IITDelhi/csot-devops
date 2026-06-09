#!/usr/bin/env bash

file="${1:-}"

awk '{print $1}' $file | sort -u | wc -l
#!/usr/bin/env bash

DIR="${1:-}"

find $DIR -size +1M -printf '%s\t%P\n' | sort -rn 
#!/usr/bin/env bash

DIR="${1:-}"

find $DIR -type f -print0 | xargs -0 sed -i 's/\t/    /g'
#!/usr/bin/env bash

DIR="${1:-}"

find $DIR -type f -name '*.txt' -print0 | xargs -0 -I{} mv {} $'{}[:-3]'.md
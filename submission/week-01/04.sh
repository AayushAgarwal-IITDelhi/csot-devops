#!/usr/bin/env bash

DIR="${1:-}"

#find $DIR -type f -name '*.txt' -print0 -exec mv {} $"{}%.txt".md \;

rename(){
    for file in "$1"/*.txt; do
        if [ ! -e "$file" ]; then 
            continue
        fi
        mv "$file" "${file%.txt}.md"
    done
    
    for file in "$1"/*; do
        if [ ! -e "$file" ]; then 
            continue
        fi
        if [[ -d "$file" ]]; then
            rename "$file"
        fi
    done
}

rename "$DIR"
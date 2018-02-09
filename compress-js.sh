#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

declare dest=./lib/hanami/ujs/assets/javascripts/hanami-ujs.js
declare compressed=./lib/hanami/ujs/assets/javascripts/hanami-ujs.min.js

check_uglifyjs() {
    if [ -z "$(command -v uglifyjs)" ]; then
        echo "Uglifyjs not found. Please install."
        exit 1
    fi
}

concat_files() {
    cat /dev/null >$dest
    for file in `bundle show vanilla-ujs`/lib/assets/javascripts/vanilla-ujs/*; do
        cat $file >> $dest
    done
}

compress_files() {
    uglifyjs --compress --mangle -- $dest > $compressed
}

main() {
  check_uglifyjs &&
  concat_files &&
  compress_files
}

main

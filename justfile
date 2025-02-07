default:
    @just --list

clean:
    rm -rf public/

build:
    hugo

watch:
    hugo serve --buildDrafts --buildFuture

test extern="f":
    #!/usr/bin/env bash 
    set -euo pipefail
    hugo serve &
    HUGO_PID=$!
    trap 'kill $HUGO_PID 2>/dev/null' EXIT 

    echo "Waiting for Hugo server to start..."
    sleep 1

    linkchecker {{if extern != "f" {"--check-extern"} else {""} }} http://localhost:1313

clean-build: clean build

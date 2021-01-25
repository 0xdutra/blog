#!/bin/bash

HOST="blog.0xdutra.com"
USER="freebsd"
REMOTE_DIR="/usr/local/share/blog/"

function check_commands() {
    if ! command -v hugo &> /dev/null; then
        echo "Please, install hugo :)"
        exit 1

    elif ! command -v rsync &> /dev/null; then
        echo "Please, install rsync :)"
        exit 1
    fi
}

function main() {
    echo "[+] Executing hugo site static generator..."
    hugo

    echo "[+] Executing deploy to ${HOST}"
    rsync -avz --delete public/ ${USER}@${HOST}:/${REMOTE_DIR}

    exit 0
}

check_commands
main

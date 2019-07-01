#!/bin/bash

cd $(dirname "$0")

mkdir -p ~/bin

download() {
    curl -s -f -S -o ~/bin/$1 https://raw.githubusercontent.com/labaneilers/selfiecert/master/$1
    ERROR="$?"
    if [ ! "$ERROR" = "0" ]; then
        echo "Failed to download"
        exit 1
    fi
}

download "selfiecert"
download "selfiecert-config.cnf"
download "selfiecert-trust-ca.ps1"

chmod +x ~/bin/selfiecert

TESTED=$(which selfiecert)
if [[ "$TESTED" = "" ]]; then
    echo "selfiecert was installed at ~/bin/selfiecert, but it wasn't on your PATH."
    exit 1
fi

echo "selfiecert installed successfully at ~/bin/selfiecert"
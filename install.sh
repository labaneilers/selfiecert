#!/bin/bash

cd $(dirname "$0")

mkdir -p ~/bin
curl -s -f -S -o ~/bin/selfiecert https://raw.githubusercontent.com/labaneilers/selfiecert/master/selfiecert
ERROR="$?"
if [ ! "$ERROR" = "0" ]; then
    echo "Failed to download"
    exit 1
fi

chmod +x ~/bin/selfiecert

TESTED=$(which selfiecert)
if [[ "$TESTED" = "" ]]; then
    echo "selfiecert was installed at ~/bin/selfiecert, but it wasn't on your PATH."
    exit 1
fi

echo "selfiecert installed successfully at ~/bin/selfiecert"
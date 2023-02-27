#!/bin/bash

set -e
set -x

for f in *.wasm; do
    LD_LIBRARY_PATH=$HOME/other/binaryen/lib $HOME/other/binaryen/bin/wasm-opt -all --nominal $f -o "$(basename "$f" .wasm).wat" -S --name-types
done

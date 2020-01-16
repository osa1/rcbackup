#!/bin/bash

# Example
# echo "4d 3b a5 58 03 00 00" | asm.sh

set -e

bytes="$(cat)"

tmp1="$(mktemp XXXX.c)"
tmp2="$(mktemp XXXX.o)"
echo "void main() {}" > $tmp1
gcc -c $tmp1 -o $tmp2

tmp3="$(mktemp XXXX.bin)"
echo "$bytes" | xxd -r -p > $tmp3
objcopy --add-section .text.test=$tmp3 $tmp2
objdump -d --section .text.test $tmp2

rm -f $tmp1 $tmp2 $tmp3

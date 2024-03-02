#!/bin/bash

mkdir -p build

PS4='• '
set -x

# Bootloader

nasm src/boot/loader.asm -f bin -o build/loader.bin || exit # compile bootloader to binary
cp build/loader.bin build/lost.img # copy to floppy disk
truncate -s 1440k build/lost.img # truncate to 1.44MB floppy disk
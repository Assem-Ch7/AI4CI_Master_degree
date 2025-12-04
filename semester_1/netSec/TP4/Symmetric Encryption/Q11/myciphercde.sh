#!/bin/bash

TARGET=$1
KEY=$2
ALGO=$3

if [ -z "$TARGET" ] || [ -z "$KEY" ] || [ -z "$ALGO" ]; then
    echo "Usage: ./myciphercde.sh <file_or_dir> <password> <algorithm>"
    exit 1
fi

if [ -d "$TARGET" ]; then
    echo "[*] Target is a DIRECTORY. Archiving and Encrypting..."
    tar -czf - "$TARGET" | openssl enc -"$ALGO" -salt -pbkdf2 -pass pass:"$KEY" -out "${TARGET}.tar.enc"
    echo "[+] Done. Output: ${TARGET%.*}.enc"

elif [ -f "$TARGET" ]; then
    echo "[*] Target is a FILE. Encrypting..."
    openssl enc -"$ALGO" -salt -pbkdf2 -pass pass:"$KEY" -in "$TARGET" -out "${TARGET}.enc"
    echo "[+] Done. Output: ${TARGET%.*}.enc"

else
    echo "Error: Target not found."
fi

#!/bin/bash

TARGETS=(
"100.64.0.2 router-siteAinternet"
"100.65.0.2 router-siteBinternet"
"100.66.0.2 router-cloudAinternet"
"8.8.8.8 google-dns"
# 3 out of 4 are supposed to fail in the initial configuration
"10.10.0.10 developerA"
"10.10.0.11 staffA"
"10.11.0.10 developerB"
"10.11.0.11 staffB"
"10.13.0.40 secureserver"
"10.12.0.30 productionserver"
"10.12.0.20 devserver"
)

echo "==== PING CHECK START ===="

for entry in "${TARGETS[@]}"; do
    IP=$(echo "$entry" | awk '{print $1}')
    NAME=$(echo "$entry" | awk '{print $2}')

    echo -n "Checking $NAME ($IP): "

    if ping -c 1 -W 1 "$IP" > /dev/null 2>&1; then
        echo "SUCCESS"
    else
        echo "FAILURE"
    fi
done

echo "==== PING CHECK COMPLETE ===="

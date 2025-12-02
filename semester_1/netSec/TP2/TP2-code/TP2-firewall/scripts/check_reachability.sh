#!/bin/bash

# Function to check HTTP connection
check_prod_connection() {
    local url="http://10.12.0.30:8080"
    
    if curl --silent --fail --connect-timeout 2 "$url" > /dev/null; then
        echo "Connection to production server is possible."
    else
        echo "Unable to connect to production server."
    fi
}

check_dev_connection() {
    local url="http://10.12.0.20:8080"
    
    if curl --silent --fail --connect-timeout 2 "$url" > /dev/null; then
        echo "Connection to development server is possible."
    else
        echo "Unable to connect to development server."
    fi
}

check_quic_connection() {
    local url="https://10.13.0.40:443"
    
    if curl --http3 --silent --insecure --fail --connect-timeout 2 "$url" > /dev/null; then
        echo "Connection to secure server is possible."
    else
        echo "Unable to connect to secure server."
    fi
}

# Call the function
check_prod_connection
check_dev_connection
check_quic_connection
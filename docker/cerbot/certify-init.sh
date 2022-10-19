#!/bin/bash

# Waits for proxy to be available, then gets the first certificate

set -e

# NetCat "nc" command checkes weather a TCP port is accecable 
until nc -z proxy 80; do
    echo "Waiting for proxy..."
    sleep 5s & wait ${!}
done

echo "Getting certificate..."

# -d is to get the certificate for the given domain name
# -- email is a requirment when using certbot
# --rsa-key-size 4096 is the recommended key size when using certbot
# --agree-tos agree to the term of service of certbot
# --noninteractive no input by our side --no-input
certbot certonly \
    --webroot \
    --webroot-path "/vol/www/" \
    -d "$DOMAIN" \
    --email $EMAIL \
    --rsa-key-size 4096 \
    --agree-tos \
    --noninteractive


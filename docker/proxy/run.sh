#!/bin/bash

set -e

echo "Checking for dhparams.pem"
if [ ! -f "/vol/proxy/ssl-dhparams.pem" ]; then
    echo "dhparams.pem does not exist!!!! --- Creating it"
    openssl dhparam -out /vol/proxy/ssl-dhparams.pem 2048
fi

# Avoid replacing these with envsubst
export host=\$host
export request_uri=\$request_uri

# This fill will exist if certificate exist
echo "Checking for fullchain.pem"
if [ ! -f "/etc/letsencrypt/live/${DOMAIN}/fullchain.pem" ]; then
    # run the configration file without ssl connection configration
    echo "SSL certificate does not exist. --- Enabling HTTP only..."
    envsubst < /etc/nginx/default.conf.tpl > /etc/nginx/conf.d/default.conf
else
    # if exist run the configration file for ssl connection
    echo "SSL certificate exist. --- Enabling HTTPS..."
    envsubst < /etc/nginx/default-ssl.conf.tpl > /etc/nginx/conf.d/default.conf
fi

# starts nginx server as a master application and not in the background
nginx -g 'daemon off;'
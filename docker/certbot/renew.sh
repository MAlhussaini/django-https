#!/bin/sh

set -e

cd /home/ec2-user/django-https
/user/local/bin/docker-compose -f docker-compose.deploy.yml run --rm certbot renew
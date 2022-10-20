#!/bin/sh
echo "foo"

# if error, exit the script
set -e
echo "foo2"
cat <(echo "yes") - | python manage.py flush
python manage.py migrate --no-input
echo "foo3"
python manage.py createsuperuser --no-input
# python manage.py createsuperuser --username admin --password admin --email foo@foo.foo; exit 0
echo "foo4"
python manage.py collectstatic --no-input
echo "foo5"
# python manage.py runserver 0.0.0.0:8000
uwsgi --socket :9000 --workers 4 --master --enable-threads --module app.wsgi

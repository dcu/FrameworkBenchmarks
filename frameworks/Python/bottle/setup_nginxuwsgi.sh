#!/bin/bash

fw_depends python2 nginx

sed -i 's|include .*/conf/uwsgi_params;|include '"${NGINX_HOME}"'/conf/uwsgi_params;|g' nginx.conf

$PY2_ROOT/bin/pip install --install-option="--prefix=${IROOT}/py2" -r $TROOT/requirements.txt

nginx -c $TROOT/nginx.conf
$PY2_ROOT/bin/uwsgi --ini $TROOT/uwsgi.ini --processes $MAX_THREADS --wsgi app:app &

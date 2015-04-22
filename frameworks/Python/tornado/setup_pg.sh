#!/bin/bash

fw_depends python2

$PY2_ROOT/bin/pip install --install-option="--prefix=${PY2_ROOT}" -r $TROOT/requirements.txt

$PY2_ROOT/bin/python server.py --port=8080 --postgres=${DBHOST} --logging=error &

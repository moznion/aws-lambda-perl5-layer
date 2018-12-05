#!/bin/bash

BASE_DIR="/tmp/layer"

cd "/opt" || exit 1

cp "${BASE_DIR}/bootstrap" .
chmod 755 'bootstrap'

zip -r "${BASE_DIR}/lambda-layer-perl-${TAG}.zip" .


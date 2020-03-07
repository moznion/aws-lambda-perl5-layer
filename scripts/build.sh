#!/bin/bash

BASE_DIR="/tmp/layer"

cd "/opt" || exit 1

cp "${BASE_DIR}/bootstrap" .
chmod 755 'bootstrap'

# XXX copy some libs for workaround: https://github.com/moznion/aws-lambda-perl5-layer/issues/6
cp -R /lib64/libcrypt* ./lib/
cp -R /usr/lib64/libcurl* ./lib/

zip -r "${BASE_DIR}/lambda-layer-perl-${TAG}.zip" .


#!/bin/bash

set -ue

BASE_DIR="/tmp/layer"

yum install -y zip

if [ -f "$BASE_DIR/perl-${PERL_VERSION}.tar.gz" ]; then
  curl -L https://raw.githubusercontent.com/tokuhirom/Perl-Build/master/perl-build | perl - "$BASE_DIR/perl-${PERL_VERSION}.tar.gz" /opt/
else
  curl -L https://raw.githubusercontent.com/tokuhirom/Perl-Build/master/perl-build | perl - "$PERL_VERSION" /opt/
fi

curl -L https://cpanmin.us | /opt/bin/perl - App::cpanminus
/opt/bin/cpanm -n --installdeps "$BASE_DIR"

cd "/opt" || exit 1

cp "${BASE_DIR}/bootstrap" .
chmod 755 'bootstrap'

zip -r "${BASE_DIR}/lambda-layer-perl-${PERL_VERSION}.zip" .


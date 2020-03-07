#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

my @perl_versions = qw/5.26.3 5.28.2 5.30.1/;

for my $perl_version (@perl_versions) {
    $perl_version =~ /([0-9]+[.][0-9]+)[.][0-9]+/;
    my $container_version = $1;
    system("make build-docker-image PERL_VERSION=$perl_version CONTAINER_TAG=$container_version");
    system("make build CONTAINER_TAG=$container_version");
}


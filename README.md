aws-lambda-perl5-layer
==

This repository provides the Perl5 layer for AWS Lambda with runtime API.

How to use
--

### 1. Using provided layers

#### ARN

- `arn:aws:lambda:${REGION}:652718333417:layer:perl-5_26-layer:1`
- `arn:aws:lambda:${REGION}:652718333417:layer:perl-5_28-layer:1`

##### Supported regions

- ap-northeast-1
- ap-northeast-2
- ap-south-1
- ap-southeast-1
- ap-southeast-2
- ca-central-1
- eu-central-1
- eu-west-1
- eu-west-2
- eu-west-3
- sa-east-1
- us-east-1
- us-east-2
- us-west-1
- us-west-2

### 1'. Building a layer yourself

If you want to build a layer and use that instead of provided layer, please follow the following sequence.

#### How to build a layer

```
$ make build-docker-container PERL_VERSION=x.x.x CONTAINER_TAG=x.x
$ make build CONTAINER_TAG=x.x
```

NOTE: `x.x.x` and `x.x` means perl runtime version (e.g. `5.28.1` and `5.28`). You can specify as you like.

Then this command stats to create a zip archive as `lambda-layer-perl-x.x.zip`.

--

Or you can use pre-built docker container (RECOMMENDED!):

```
$ make build CONTAINER_TAG=x.x DOCKER_HUB_ACCOUNT='moznion/'
```

Please refer to the following so that getting available containers: https://hub.docker.com/r/moznion/lambda-perl-layer-foundation/

#### How to publish the layer

```sh
aws --region "$REGION" --profile "$PROFILE" lambda publish-layer-version \
      --layer-name "perl-x.x" \
      --zip-file "fileb://lambda-layer-perl-x.x.zip"
```

### 2. Create a Lambda function and publish it

Please refer: [moznion/aws-lambda-perl5-layer-example](https://github.com/moznion/aws-lambda-perl5-layer-example)

If you register the handler as `handler.handle`, you have to write code into `handler.pl` file and it must have `handle` subroutine.

An simple example is below (`handler.pl`):

```perl
#!perl

use strict;
use warnings;
use utf8;

sub handle {
    my ($payload) = @_;

    # do something
    ...

    # if you want to finish the execution as failed, please die

    # NOTE: must return hashref or arrayref
    return +{
        'msg' => 'OK',
        'this is' => 'example',
    };
}

1; # must return TRUE value here!
```

And there is necessary to publish the function with layer information. Please refer to the following example: [How to publish a function](https://github.com/moznion/aws-lambda-perl5-layer-example/tree/master/simple#how-to-publish-a-function)

FAQ
--

### How to build a Lambda function with package vendoring?

You have to build a function zip with the perl runtime that is the same version as Lambda's one.

Please refer: [https://github.com/moznion/aws-lambda-perl5-layer-example/tree/master/simple](https://github.com/moznion/aws-lambda-perl5-layer-example/tree/master/simple)

For Developers
--

### How to publish foundation docker container

```
$ make build-docker-container PERL_VERSION=x.x.x CONTAINER_TAG=x.x
$ make publish-docker-image CONTAINER_TAG=x.x DOCKER_ID_USER=xxx
```

### How to build foundation docker container without caching

```
$ make build-docker-container PERL_VERSION=x.x.x CONTAINER_TAG=x.x OPT='--no-cache'
```

See Also
--

- https://docs.aws.amazon.com/lambda/latest/dg/runtimes-custom.html

Authoer
--

moznion (<moznion@gmail.com>)

License
--

```
The MIT License (MIT)
Copyright © 2018 moznion, http://moznion.net/ <moznion@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

aws-lambda-perl5-layer
==

This repository provides the Perl5 layer for AWS Lambda with runtime API.

** This is under development **

How to build a layer
--

```
$ make PERL_VERSION=x.x.x
```

Then this command stats to create a zip archive as `lambda-layer-perl-x.x.x.zip`.

(NOTE: `x.x.x` means perl runtime version. You can specify as you like)

How to use
--

1. Register the built zip archive of layer as a layer.
2. Create a perl function
  - If you register the handler as `handler.handle`, you have to write code into `handler.pl` file and it must have `handle` subroutine
3. Enjoy :tada:

How to create a perl function
--

An example is shown below (`handler.pl`):

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

### How to solve dependencies

To Be Documented...

TODO
--

- [ ] Publish a layer to AWS and provide ARN

See Also
--

- https://docs.aws.amazon.com/lambda/latest/dg/runtimes-custom.html

Authoer
--

moznion (<moznion@gmail.com>)

License
--

MIT


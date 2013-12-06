package DB::Base;

use Moose;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;

has 'base' => (
    is => 'ro',
    isa => 'Object',
);

1;

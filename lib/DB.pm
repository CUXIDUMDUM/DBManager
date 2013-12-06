package DB;

use Moose;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;
use Class::Load qw(:all);

sub model {
    my ($self, $engine) = @_;
    my $c = ref($self);
    $c .= '::' . ucfirst(lc($engine));
    load_class($c);
    return $c->new( base => $self );
}

1;

package DB::Roles::Core;

use Moose::Role;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;
use MooseX::Types::Path::Class;
#with 'MooseX::Role::DBIx::Connector';

requires qw(create_db drop_db run_ddl driver_name);

has 'schema_file' => (
    is => 'rw',
    isa => 'Path::Class::File',
    coerce => 1,
    default => 'etc/sqlite/demo.sql',
);

sub install {
    my ($self) = @_;
    $self->create_db();
    $self->run_ddl($self->schema_file->stringify);
    return;
}

1;

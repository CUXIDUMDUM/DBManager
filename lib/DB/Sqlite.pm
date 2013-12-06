package DB::Sqlite;

use Moose;
use namespace::autoclean;
use 5.019;
use Data::Dump qw(dump);
use Carp;
use IPC::ShellCmd;

extends 'DB::Base';

with 'DB::Roles::Core';

has 'db' => (
    is => 'ro',
    isa => 'Str',
    default => 'var/testdb',
);

sub create_db {
    my ($self) = @_;
    system("touch " . $self->db) unless -e $self->db;
    say "Created database";
}

sub drop_db {
    my ($self) = @_;
    system("rm " . $self->db) if -e $self->db;
    say "Dropped database";
}

sub get_cli_exe {
    my ($self) = @_;
    my $sqlite3_exe = `which sqlite3`;
    chomp($sqlite3_exe);
    return $sqlite3_exe;
}

sub cli_args {
    my ($self) = @_;
    my @cli = $self->get_cli_exe();
    push(@cli, $self->db);
    return @cli;
}

sub run_ddl {
    my ($self, $schema_file) = @_;
    my $cmd = [ $self->cli_args() ];
    my $ips = IPC::ShellCmd->new($cmd);
    $ips->stdin('-filename' => $schema_file);
    $ips->run();
    say $ips->stdout;
    say $ips->stderr;
    return $ips->status;
}

sub driver_name {
    return 'SQLite';
}

1;

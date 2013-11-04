#!/usr/bin/env perl
use 5.010;
use utf8;
use strict;
use warnings;
use lib 'perl5';
use DDP;
use File::Slurp;
use Mojo::JSON;
use Mojo::UserAgent;
use Time::Piece;

my %args = @ARGV;

say 'Iron-Play v0.0.1';
say localtime->datetime;

say 'Environment: ' . p(%ENV);
say 'Arguments: ' . p(%args);

my $file = $args{-payload};
my $payload = Mojo::JSON->new->decode( read_file($file) );

say "Payload ($file): " . p($payload);

my $work = int rand 20;
print "Doing work ($work): ";
for (1..$work) {
    print '.';
}

say '';
say 'Done.';

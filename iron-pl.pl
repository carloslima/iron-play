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

my $ua   = Mojo::UserAgent->new;
my %args = @ARGV;

say 'Iron-Play v0.0.1';
say localtime->datetime;

say 'Environment: ' . p(%ENV);
say 'Arguments: ' . p(%args);

my $file    = $args{-payload};
my $payload = Mojo::JSON->new->decode( read_file($file) );

say "Payload ($file): " . p($payload);

foreach my $tag ( @{ $payload->{tags} } ) {
    say '';
    say "Top users for tag '$tag':";
    say join "\n", @{ top_users($tag) };
}

say '';
say 'Done.';

sub top_users {
    my $tag = shift or die 'No tag especified';
    my $users = $ua->get(
        "http://api.stackexchange.com/2.1/tags/$tag/top-answerers/month",
        form => { pagesize => 3, site => 'stackoverflow' }
    )->res->json->{items};
    return [ map { "$_->{user}{display_name}: $_->{user}{reputation}" }
          @$users ];
}

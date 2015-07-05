#!/usr/bin/perl
use vars qw($VERSION %IRSSI);

$VERSION = "2015070501";
%IRSSI = (
    authors     => "Roni 'rolle' Laukkarinen",
    contact     => "roni\@dude.fi",
    name        => "lastactive2web",
    description => "Write away information to a file to be used on web pages",
    license     => "BSD",
    changed     => "$VERSION",
);
use strict;
use Irssi::Irc;
use Time::Duration qw/duration_exact/;

sub savelog {
    my $server = shift;
    my ($server, $msg, $nick, $address) = @_;
    open(STATUSFILE, q{>}, $ENV{'HOME'}.'/public_html/lastactive.log') || die ("lastactive2web.pl: Could not open file for writing:".$!);
    print STATUSFILE time;
    close(STATUSFILE);
}

Irssi::signal_add("away mode changed", "savelog");
Irssi::signal_add("message own_public", "savelog");
Irssi::signal_add("message own_private", "savelog");

print CLIENTCRAP '%B>>%n '.$IRSSI{name}.' '.$VERSION.' (c) '.$IRSSI{authors}.' loaded';
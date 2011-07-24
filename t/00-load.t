#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'HTML::Cleaner' ) || print "Bail out!\n";
}

diag( "Testing HTML::Cleaner $HTML::Cleaner::VERSION, Perl $], $^X" );

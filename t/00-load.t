#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'DB::CouchDB::Magic' );
}

diag( "Testing DB::CouchDB::Magic $DB::CouchDB::Magic::VERSION, Perl $], $^X" );

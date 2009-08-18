#!/usr/bin/perl -Ilib

use strict;
use warnings;
use DB::CouchDB::Magic;
use Data::Dumper;

my $doc = '0f92897608f0ff1aa37e543acc4831b8';


my $db = DB::CouchDB::Magic->new(
    host => 'localhost',
    db   => 'umleitung',
);
my $_doc = $db->get_doc_encoded( $doc );
$_doc->{blubb} = 'blablubbü';
#$_doc->{blbb} = 'blubbüaa';
delete $_doc->{blbb};
$db->handle_blessed(1);
my $res = $db->update_doc_encoded( $doc, $_doc );

print Dumper($res);
#print Dumper($_doc);

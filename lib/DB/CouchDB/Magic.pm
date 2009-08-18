package DB::CouchDB::Magic;

use warnings;
use strict;
use base 'DB::CouchDB';
use MIME::Base64;

=head1 NAME

DB::CouchDB::Magic - An extension for DB::CouchDB that does magic stuff

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

I needed some functionality that might become redundant in the future
but are required right now to get stuff done. one of them is "on-th-fly"
Base64 encoding for non ASCII character as they can break CouchDB.

    use DB::CouchDB::Magic;

    my $db = DB::CouchDB::Magic->new();
    ...

See the C<DB::CouchDB> man page for more details

=head1 FUNCTIONS

=head2 get_doc_encoded

works like get_doc but decodes Base64 encoded filds defined in the key
"base64" as an array.

=cut

sub get_doc_encoded {
    my $self = shift;
    my $doc  = shift;
    my $tmp  = DB::CouchDB::Result->new(
        $self->_call( GET => $self->_uri_db_doc($doc) ) );
    if ( $tmp->{base64} ) {
        foreach my $key ( @{ $tmp->{base64} } ) {
            $tmp->{$key} = decode_base64( $tmp->{$key} );
        }
        delete $tmp->{base64};
    }
    return $tmp;
}

=head2 update_doc_encoded

works like update_doc but encodes non ASCII characters to Base64 values
and pushes the key into the "base64" array.

=cut

sub update_doc_encoded {
    my $self = shift;
    my $name = shift;
    my $doc  = shift;
    
    foreach my $key (%{$doc}){
        next unless $doc->{$key};
        if($doc->{$key} =~ /([^\x{00}-\x{7f}])/){
            $doc->{$key} = encode_base64($doc->{$key});
            push(@{$doc->{base64}}, $key);
        }
    }

    my $jdoc = $self->json()->encode($doc);
    return DB::CouchDB::Result->new(
        $self->_call(
            PUT => $self->_uri_db_doc($name),
            $jdoc
        )
    );
}


=head1 AUTHOR

Lenz Gschwendtner, C<< <norbu09 at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-db-couchdb-magic at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=DB-CouchDB-Magic>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc DB::CouchDB::Magic


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=DB-CouchDB-Magic>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/DB-CouchDB-Magic>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/DB-CouchDB-Magic>

=item * Search CPAN

L<http://search.cpan.org/dist/DB-CouchDB-Magic/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Lenz Gschwendtner, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1;    # End of DB::CouchDB::Magic
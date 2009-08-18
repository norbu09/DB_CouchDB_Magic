use inc::Module::Install;

name     'DB-CouchDB-Magic';
all_from 'lib/DB/CouchDB/Magic.pm';
author   'Lenz Gschwendtner <norbu09@cpan.org>';
license  'perl';

requires 'MIME::Base64';
requires 'Encoding::FixLatin';

build_requires 'Test::More';

auto_install;

WriteAll;


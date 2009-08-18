use inc::Module::Install;

name     'DB-CouchDB-Magic';
all_from 'lib/DB/CouchDB/Magic.pm';
author   'Lenz Gschwendtner <norbu09@cpan.org>';
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;


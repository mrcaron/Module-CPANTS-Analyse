use strict;
use warnings;
use Test::More;
use Test::Warnings qw/warning/;

use Module::CPANTS::Analyse;
use File::Spec::Functions;
use Cwd qw(cwd);

my $a=Module::CPANTS::Analyse->new({
    dist=>'t/eg/not_extractable.gz',
    _dont_cleanup=>$ENV{DONT_CLEANUP},
});

my $dir = cwd;
my $rv;
like(warning {$rv=$a->unpack},
            qr/^No handler available for/,
            , 'unpack warns');

like($rv,qr/Can.t call method .extract./,'unpack failed');
is($a->d->{extractable},0,'extractable');

END {
    chdir $dir; # work around RT #67509
}

done_testing;

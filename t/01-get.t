#!perl

use Test::More $ENV{YC_LIVE_TESTS} ? "no_plan" : (skip_all => "Set YC_LIVE_TESTS to use Yars configuration ");
use Yars::Client;
use Log::Log4perl;
use File::Temp;
use Cwd qw/getcwd/;

use strict;
use warnings;

Log::Log4perl->easy_init(level => "WARN");

diag "Contacting Yars server";

my $yc = Yars::Client->new;

ok $yc, "made a client object";

my $welcome = $yc->welcome;

like $welcome, qr/welcome to [yars|RESTAS]/i, "got welcome message";

like $yc->server_type, qr/[Yars|RESTAS]/, 'server type';

my $status = $yc->status;
ok $status->{server_version}, 'server status';

my $pwd = getcwd;
my $dir = File::Temp->newdir;
chdir $dir;
# Get a gzipped file
ok $yc->download("https://omisips1.omisips.eosdis.nasa.gov:8000/File/2566ff079adc7a472de4d108a7c3752f/NISE_SSMIF13_20050118.HDFEOS");
chdir $pwd;

1;


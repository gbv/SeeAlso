use v5.14.1;
use Test::More;
use Plack::Test;
use HTTP::Request::Common;

use lib 't';
use AppLoader;
my $app = AppLoader->new( seealso => 'GBV::App::SeeAlso' );

test_psgi $app, sub {
    my $cb = shift;
    my $res = $cb->(GET "/");
    is $res->code, '200', "/";

    foreach my $url (qw(/pnd2vd17)) {
        my $res = $cb->(GET $url);
        is $res->code, '300', $url;
    }
};

done_testing;

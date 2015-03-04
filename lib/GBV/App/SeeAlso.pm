package GBV::App::SeeAlso;
use v5.14.1;

our $VERSION="0.0.0";
our $NAME="seealso";

use YAML qw(LoadFile);
use Plack::Builder;
use Plack::Request;
use parent 'Plack::Component';

# load config file
sub config {
    my ($self, $file) = @_;
    return unless -f $file;

    say $file;
    my $config = LoadFile($file);
    while (my ($key, $value) = each %$config) {
        $self->{$key} = $value;
        if ($key eq 'proxy' and $value !~ /^[*]\s*$/) {
            $self->{trust} = [ split /\s*,\s*|\s+/, $self->{proxy} ];
        }
    }
}

use GBV::App::SeeAlso::Example;
use GBV::App::SeeAlso::PND2VD17;

sub prepare_app {
    my ($self) = @_;
    return if $self->{app};

    # load config file
    $self->config( grep { -f $_ } "etc/$NAME.yaml", "/etc/$NAME/$NAME.yaml" );

    # build middleware stack
    $self->{app} = builder {
        enable_if { $self->{proxy} } 'XForwardedFor', trust => $self->{trust};
        enable 'CrossOrigin', origins => '*';
        enable 'Rewrite', rules => sub {
            s{^/$}{/index.html}; return
        };
        enable 'Static', path => qr{\.(html|js|ico|css|png)},
            pass_through => 1, root => "/etc/$NAME/htdocs";
        enable 'Static', path => qr{\.(html|js|ico|css|png)},
            pass_through => 1, root => './htdocs';
        enable 'ContentLength';
        builder {
            mount '/example'  => GBV::App::SeeAlso::Example->new->to_app;
            mount '/pnd2vd17' => GBV::App::SeeAlso::PND2VD17->new->to_app;
            mount '/' => sub { $self->main(@_) };
        };
    };
}

sub call {
    my ($self, $env) = @_;
    $self->{app}->($env);
}

sub main {
    [404,[],['Not found']];
}

1;
__END__
    builder {
        while (my ($path, $service) = each %{$config->{services}}) {
            say "/$path : $service";
            eval "require $service" or die;
            $service = $service->new->to_app;
            mount "/$path" => $service;
        }
        mount '/' => $app;
    }


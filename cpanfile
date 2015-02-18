requires 'perl', '5.14.1';

requires 'Data::Beacon', '0.3.1';
requires 'Plack::App::SeeAlso';
requires 'Plack::Middleware::CrossOrigin';
requires 'Plack::Middleware::XForwardedFor';
requires 'Plack::Middleware::Rewrite';

# not listed here because implied by required Debian packages:
# - Plack (starman)
# - JSON
# - YAML (libyaml-perl)
# - Template Toolkit (libtemplate-perl)

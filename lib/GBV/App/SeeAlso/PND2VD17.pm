package GBV::App::SeeAlso::PND2VD17;
use v5.14.1;

use parent 'Plack::App::SeeAlso';

our $ShortName = 'PND to VD17';
our $Description = 'Liefert zu einer PND bei vorhandenem Material einen Link in das Verzeichnis der im deutschen Sprachraum erschienenen Drucke des 17. Jahrhunderts (VD17)';
our $Examples = [ { id => '10432337X' } ];

# TODO: seealso query base set
# TODO: format=redirect

use Catmandu::Importer::SRU;
use PICA::Data qw(pica_xml_struct);

sub query {
    my ($self, $id) = @_;

    say STDERR "!!!$id";

    return unless $id =~ qr{^(http://d-nb\.info/gnd/)?([0-9X-]+)$};
    my ($gnd, $uri) = ($2,"http://d-nb.info/gnd/$2");

    # my $format = $env->{'negotiate.format'} || 'html';
    # TODO: validate $id /^[0-9X-]+$/

    my $sru = Catmandu::Importer::SRU->new( 
        base => "http://sru.gbv.de/vd17",
        query => "pica.pnd=$gnd",
        recordSchema => "picaxml",
        parser => 'struct',
    );

    my $record = $sru->next or return;
    use Catmandu -all;
    say STDERR "!!!";
    exporter('YAML')->add( $record );
    my $pica = pica_xml_struct($record, bless => 1) or return;
    exporter('YAML')->add( $pica );

    my $ppn = $pica->{_id};
    my $name = join(' ', map { $pica->values($_) } qw(028A$d 028A$a));
    my $url = "http://gso.gbv.de/DB=1.28/REL?PPN=$ppn";

    [ $uri, ["$name"], ["$name in VD17"], [$url] ];
}

1;

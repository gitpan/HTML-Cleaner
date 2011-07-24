package HTML::Cleanerer;

use strict;
use warnings;
use HTML::Entities;

=head1 NAME

HTML::Cleaner - The great new HTML::Cleaner!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.05';

=head1 SYNOPSIS

Remove unwanted tags from the HTML, but leave the content.

	<tag>content</tag>

Example,

	use HTML::TreeBuilder::Xpath;
    use HTML::Cleaner;

	my $tree = HTML::TreeBuilder::XPath->new_from_content($html);
	my $news = $tree->findnodes('//div[@id="news"]')->[0];

    my $hc = HTML::Cleaner->new();
	
	my $clean_news = $hc->clean($news->as_HTML);
	print $clean_news;

    ...

=head1 SUBROUTINES/METHODS


=cut

=head2 new 

You inicialize the class and set with tags you want strip.

=head2 clean

remove the unwanted tags.

=head2 _remove_attrs

Private method which remove all HTML attributes.

=head2 Accessors

=head3 tags

For default this contain all html tags

=head3 in_text 

This accessor contain the html tags which you would like to let.

	print Dumper $self->in_text;

To see the default value.

=cut

sub new {
    my $this  = shift;
    my $class = ref($this) || $this;
    my $self  = {};
    my $attrs = shift;
    if ($attrs) {
        $self->{tags}    = $attrs->{tags}    if $attrs->{tags};
        $self->{in_text} = $attrs->{in_text} if $attrs->{in_text};
    }
    return bless $self, $class;
}

sub tags($\@) {
    my ( $self, $tags ) = @_;
    if ($tags) {
        $self->{tags} = $tags;
    }

    return $self->{tags} if $self->{tags};

    return [
        qw/ADDRESS APPLET AREA A BASE BASEFONT BIG BLOCKQUOTE BODY BR B CAPTION CENTER CITE CODE DD DFN DIR DIV DL DT EM FONT FORM H1 H2 H3 H4 H5 H6 HEAD HR HTML IMG INPUT ISINDEX I KBD LINK LI MAP MENU META OL OPTION PARAM PRE P SAMP SCRIPT SELECT SMALL STRIKE STRONG STYLE SUB SUP TABLE TD TEXTAREA TH TITLE TR TT UL U VAR/
    ];
}

sub in_text($\@) {
    my ( $self, $in_text ) = @_;

    if ($in_text) {
        $self->{in_text} = $in_text;
    }

    return $self->{in_text} if $self->{in_text};

    return [qw/H1 H2 H3 H4 H5 H6 I B U BR TABLE TD TR LI UL A P/];
}

sub clean($;$) {
    my ( $self, $html ) = @_;
    $html = $self->_remove_attrs( decode_entities($html) );
    foreach my $tag ( @{ $self->tags } ) {
        $html =~ s#</?$tag>##ig if !grep { /$tag/i } @{ $self->in_text };
    }
    return $html;
}

sub _remove_attrs($;$) {
    my ( $self, $html ) = @_;
    $html =~ s/<(\w+)\s.+?>/<$1>/g;
    return $html;
}

=head1 AUTHOR

Daniel de Oliveira Mantovani, C<< <daniel.oliveira.mantovani at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-html-cleaner at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=HTML-Cleaner>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc HTML::Cleaner


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=HTML-Cleaner>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/HTML-Cleaner>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/HTML-Cleaner>

=item * Search CPAN

L<http://search.cpan.org/dist/HTML-Cleaner/>

=back


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Daniel de Oliveira Mantovani.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1;    # End of HTML::Cleaner

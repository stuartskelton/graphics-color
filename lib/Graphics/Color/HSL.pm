package Graphics::Color::HSL;
use Moose;
use MooseX::Aliases;

extends qw(Graphics::Color);

with 'Graphics::Color::Equal';

use Graphics::Color::Types qw(Number360OrLess NumberOneOrLess);

has 'hue' => (
    is => 'rw',
    isa => Number360OrLess,
    default => 1,
    alias => 'h'
);
has 'saturation' => (
    is => 'rw',
    isa => NumberOneOrLess,
    default => 1,
    alias => 's'
);
has 'lightness' => (
    is => 'rw',
    isa => NumberOneOrLess,
    default => 1,
    alias => 'l'
);
has 'alpha' => (
    is => 'rw',
    isa => NumberOneOrLess,
    default => 1,
    alias => 'a'
);
has 'name' => ( is => 'rw', isa => 'Str' );

sub as_string {
    my ($self) = @_;

    return sprintf('%d,%0.2f,%0.2f,%0.2f',
        $self->hue, $self->saturation, $self->lightness, $self->alpha
    );
}

sub as_percent_string {
    my ($self) = @_;

    return sprintf("%d, %d%%, %d%%, %0.2f",
        $self->hue, $self->saturation * 100, $self->lightness * 100,
        $self->alpha
    );
}

sub as_array {
    my ($self) = @_;

    return ($self->hue, $self->saturation, $self->lightness);
}

sub as_array_with_alpha {
    my ($self) = @_;

    return ($self->hue, $self->saturation, $self->lightness, $self->alpha);
}

sub equal_to {
    my ($self, $other) = @_;

    return 0 unless defined($other);

    unless($self->hue == $other->hue) {
        return 0;
    }
    unless($self->saturation == $other->saturation) {
        return 0;
    }
    unless($self->lightness == $other->lightness) {
        return 0;
    }
    unless($self->alpha == $other->alpha) {
        return 0;
    }

    return 1;
}

__PACKAGE__->meta->make_immutable;

no Moose;
1;
__END__

=head1 NAME

Graphics::Color::HSL - HSL color space

=head1 DESCRIPTION

Graphics::Color::HSL represents a Color in an RGB color space.  HSL stands for
B<Hue> B<Saturation> and B<Lightness>.

=head1 SYNOPSIS

    use Graphics::Color::HSL;

    my $color = Graphics::Color::HSL->new({
        hue         => 120,
        saturation  => .5
        lightness   => .25,
    });

=head1 CONSTRUCTOR

=head2 Graphics::Color::HSL->new(%options);

Creates a new Graphics::Color::HSL.

=head1 METHODS

=head2 equal_to

Compares this color to the provided one.  Returns 1 if true, else 0;

=head2 not_equal_to

The opposite of equal_to.

=head2 hue

=head2 h

Set/Get the hue component of this Color.

=head2 saturation

=head2 s

Set/Get the saturation component of this Color.

=head2 lightness

=head2 l

Set/Get the lightness component of this Color.

=head2 alpha

Set/Get the alpha component of this Color.

=head2 name

Get the name of this color.  Only valid if the color was created by name.

=head2 as_string

Get a string version of this Color in the form of
HUE,SATURATION,LIGHTNESS,ALPHA

=head2 as_percent_string

Return a percent formatted value for this color.  This format is suitable for
CSS HSL values.

=head2 as_array

Get the HSL values as an array

=head2 as_array_with_alpha

Get the HSLA values as an array

=head1 AUTHOR

Cory Watson, C<< <gphat@cpan.org> >>

=head1 SEE ALSO

perl(1), L<http://en.wikipedia.org/wiki/HSL_and_HSV>

=head1 COPYRIGHT & LICENSE

Copyright 2008 - 2009 by Cory G Watson

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

package Chemistry::Elements;

use strict;
require 5.003;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK $AUTOLOAD
             $debug %names %elements $maximum_Z);

require Exporter;

@ISA       = qw(Exporter);
@EXPORT_OK = qw(get_Z get_symbol get_name);
@EXPORT    = qw();
$VERSION   = 1.00;

use subs qw(_get_name_by_Z
            _get_symbol_by_Z
            _get_name_by_symbol
            _get_Z_by_symbol
            _get_symbol_by_name
            _get_Z_by_name
            _is_Z
            _is_name
            _is_symbol
            _format_name
            _format_symbol
            );


$debug = 0;

%names =
(
  1 => 'Hydrogen',
  2 => 'Helium',
  3 => 'Lithium',
  4 => 'Beryllium',
  5 => 'Boron',
  6 => 'Carbon',
  7 => 'Nitrogen',
  8 => 'Oxygen',
  9 => 'Fluorine',
 10 => 'Neon',
 11 => 'Sodium',
 12 => 'Magnesium',
 13 => 'Aluminium',
 14 => 'Silicon',
 15 => 'Phosphorous',
 16 => 'Sulfur',
 17 => 'Chlorine',
 18 => 'Argon',
 19 => 'Potassium',
 20 => 'Calcium',
 21 => 'Scandium',
 22 => 'Titanium',
 23 => 'Vanadium',
 24 => 'Chromium',
 25 => 'Manganese',
 26 => 'Iron',
 27 => 'Cobolt',
 28 => 'Nickel',
 29 => 'Copper',
 30 => 'Zinc',
 31 => 'Gallium',
 32 => 'Germanium',
 33 => 'Arsenic',
 34 => 'Selenium',
 35 => 'Bromine',
 36 => 'Krypton',
 37 => 'Rubidium',
 38 => 'Strontium',
 39 => 'Yttrium',
 40 => 'Zirconium',
 41 => 'Nobium',
 42 => 'Molybdenum',
 43 => 'Technetium',
 44 => 'Ruthenium',
 45 => 'Rhodium',
 46 => 'Paladium',
 47 => 'Silver',
 48 => 'Cadmium',
 49 => 'Indium',
 50 => 'Tin',
 51 => 'Antimony',
 52 => 'Tellurium',
 53 => 'Iodine',
 54 => 'Xenon',
 55 => 'Cesium',
 56 => 'Barium',
 57 => 'Lanthanum',
 58 => 'Cerium',
 59 => 'Praesodium',
 60 => 'Neodymium',
 61 => 'Promethium',
 62 => 'Samarium',
 63 => 'Europium',
 64 => 'Gadolinium',
 65 => 'Terbium',
 66 => 'Dysprosium',
 67 => 'Holmium',
 68 => 'Erbium',
 69 => 'Thulium',
 70 => 'Ytterbium',
 71 => 'Lutetium',
 72 => 'Hafnium',
 73 => 'Tantalum',
 74 => 'Tungsten',
 75 => 'Rhenium',
 76 => 'Osmium',
 77 => 'Iridium',
 78 => 'Platinum',
 79 => 'Gold',
 80 => 'Mercury',
 81 => 'Thalium',
 82 => 'Lead',
 83 => 'Bismuth',
 84 => 'Polonium',
 85 => 'Astatine',
 86 => 'Radon',
 87 => 'Francium',
 88 => 'Radium',
 89 => 'Actinum',
 90 => 'Thorium',
 91 => 'Protactinium',
 92 => 'Uranium',
 93 => 'Neptunium',
 94 => 'Plutonium',
 95 => 'Americium',
 96 => 'Curium',
 97 => 'Berkelium',
 98 => 'Californium',
 99 => 'Einsteinium',
100 => 'Fermium',
101 => 'Mendelevium',
102 => 'Nobelium',
103 => 'Lawerencium',
104 => 'Rutherfordium',
105 => 'Dubnium',
106 => 'Seaborgium',
107 => 'Bohrium',
108 => 'Hassium',
109 => 'Meitnerium'
);

{
my @a = sort {$a <=> $b } keys %names;
$maximum_Z = pop @a;
}

%elements = (
'H'  => '1',      '1' => 'H',
'He' => '2',      '2' => 'He',
'Li' => '3',      '3' => 'Li',
'Be' => '4',      '4' => 'Be',
'B'  => '5',      '5' => 'B',
'C'  => '6',      '6' => 'C',
'N'  => '7',      '7' => 'N',
'O'  => '8',      '8' => 'O',
'F'  => '9',      '9' => 'F',
'Ne' => '10',    '10' => 'Ne',
'Na' => '11',    '11' => 'Na',
'Mg' => '12',    '12' => 'Mg',
'Al' => '13',    '13' => 'Al',
'Si' => '14',    '14' => 'Si',
'P'  => '15',    '15' => 'P',
'S'  => '16',    '16' => 'S',
'Cl' => '17',    '17' => 'Cl',
'Ar' => '18',    '18' => 'Ar',
'K'  => '19',    '19' => 'K',
'Ca' => '20',    '20' => 'Ca',
'Sc' => '21',    '21' => 'Sc',
'Ti' => '22',    '22' => 'Ti',
'V'  => '23',    '23' => 'V',
'Cr' => '24',    '24' => 'Cr',
'Mn' => '25',    '25' => 'Mn',
'Fe' => '26',    '26' => 'Fe',
'Co' => '27',    '27' => 'Co',
'Ni' => '28',    '28' => 'Ni',
'Cu' => '29',    '29' => 'Cu',
'Zn' => '30',    '30' => 'Zn',
'Ga' => '31',    '31' => 'Ga',
'Ge' => '32',    '32' => 'Ge',
'As' => '33',    '33' => 'As',
'Se' => '34',    '34' => 'Se',
'Br' => '35',    '35' => 'Br',
'Kr' => '36',    '36' => 'Kr',
'Rb' => '37',    '37' => 'Rb',
'Sr' => '38',    '38' => 'Sr',
'Y'  => '39',    '39' => 'Y',
'Zr' => '40',    '40' => 'Zr',
'Nb' => '41',    '41' => 'Nb',
'Mo' => '42',    '42' => 'Mo',
'Tc' => '43',    '43' => 'Tc',
'Ru' => '44',    '44' => 'Ru',
'Rh' => '45',    '45' => 'Rh',
'Pd' => '46',    '46' => 'Pd',
'Ag' => '47',    '47' => 'Ag',
'Cd' => '48',    '48' => 'Cd',
'In' => '49',    '49' => 'In',
'Sn' => '50',    '50' => 'Sn',
'Sb' => '51',    '51' => 'Sb',
'Te' => '52',    '52' => 'Te',
'I'  => '53',    '53' => 'I',
'Xe' => '54',    '54' => 'Xe',
'Cs' => '55',    '55' => 'Cs',
'Ba' => '56',    '56' => 'Ba',
'La' => '57',    '57' => 'La',
'Ce' => '58',    '58' => 'Ce',
'Pr' => '59',    '59' => 'Pr',
'Nd' => '60',    '60' => 'Nd',
'Pm' => '61',    '61' => 'Pm',
'Sm' => '62',    '62' => 'Sm',
'Eu' => '63',    '63' => 'Eu',
'Gd' => '64',    '64' => 'Gd',
'Tb' => '65',    '65' => 'Tb',
'Dy' => '66',    '66' => 'Dy',
'Ho' => '67',    '67' => 'Ho',
'Er' => '68',    '68' => 'Er',
'Tm' => '69',    '69' => 'Tm',
'Yb' => '70',    '70' => 'Yb',
'Lu' => '71',    '71' => 'Lu',
'Hf' => '72',    '72' => 'Hf',
'Ta' => '73',    '73' => 'Ta',
'W'  => '74',    '74' => 'W',
'Re' => '75',    '75' => 'Re',
'Os' => '76',    '76' => 'Os',
'Ir' => '77',    '77' => 'Ir',
'Pt' => '78',    '78' => 'Pt',
'Au' => '79',    '79' => 'Au',
'Hg' => '80',    '80' => 'Hg',
'Tl' => '81',    '81' => 'Tl',
'Pb' => '82',    '82' => 'Pb',
'Bi' => '83',    '83' => 'Bi',
'Po' => '84',    '84' => 'Po',
'At' => '85',    '85' => 'At',
'Rn' => '86',    '86' => 'Rn',
'Fr' => '87',    '87' => 'Fr',
'Ra' => '88',    '88' => 'Ra',
'Ac' => '89',    '89' => 'Ac',
'Th' => '90',    '90' => 'Th',
'Pa' => '91',    '91' => 'Pa',
'U'  => '92',    '92' => 'U',
'Np' => '93',    '93' => 'Np',
'Pu' => '94',    '94' => 'Pu',
'Am' => '95',    '95' => 'Am',
'Cm' => '96',    '96' => 'Cm',
'Bk' => '97',    '97' => 'Bk',
'Cf' => '98',    '98' => 'Cf',
'Es' => '99',    '99' => 'Es',
'Fm' => '100',  '100' => 'Fm',
'Md' => '101',  '101' => 'Md',
'No' => '102',  '102' => 'No',
'Lr' => '103',  '103' => 'Lr',
'Rf' => '104',  '104' => 'Rf',
'Ha' => '105',  '105' => 'Ha',
'Sg' => '106',  '106' => 'Sg',
'Bh' => '107',  '107' => 'Bh',
'Hs' => '108',  '108' => 'Hs',
'Mt' => '109',  '109' => 'Mt'
);

sub new
	{
	my $class = shift;
	my $data  = shift;

	my $self = {};
	bless $self, $class;

	if( _is_Z $data )
		{
		$self->Z($data);
		}
	elsif( _is_symbol $data )
		{
		$self->symbol($data);
		}
	elsif( _is_name $data )
		{
		$self->name($data);
		}
	else
		{
		return;
		}

	return $self;
	}

sub Z
	{
	my $self = shift;
	my $data = shift;
	
	return $self->{'Z'} unless $data;

	unless( _is_Z $data )
		{
		$self->error('$data is not a valid proton number');
		return;
		}

	$self->{'Z'}      = $data;
	$self->{'name'}   = _get_name_by_Z $data;
	$self->{'symbol'} = _get_symbol_by_Z $data;

	return $data;
	}

sub name
	{
	my $self = shift;
	my $data = shift;
	
	return $self->{'name'} unless $data;

	unless( _is_name $data)
		{
		$self->error('$data is not a valid name');
		return;
		}

	$self->{'name'}   = _format_name $data;
	$self->{'Z'}      = _get_Z_by_name $data;
	$self->{'symbol'} = _get_symbol_by_Z($self->Z);

	return $data;
	}

sub symbol
	{
	my $self = shift;
	my $data = shift;
	
	return $self->{'symbol'} unless $data;

	unless( _is_symbol $data )
		{
		$self->error('$data is not a valid chemical symbol');
		return;
		}

	$self->{'symbol'} = _format_symbol $data;
	$self->{'Z'}      = _get_Z_by_symbol $data;
	$self->{'name'}   = _get_name_by_Z $self->Z;

	return $data;
	}

sub get_symbol
	{
	my $thingy = shift;

	#since we were asked for a name, we'll suppose that we were passed
	#either a chemical symbol or a Z.
	return _get_symbol_by_Z($thingy)      if _is_Z $thingy;
	return _get_symbol_by_name($thingy)   if _is_name $thingy;

	#maybe it's already a symbol...
	return _format_symbol $thingy if _is_symbol $thingy;

	#we were passed something wierd.  pretend we don't know anything.
	return;
	}

sub _get_symbol_by_name
	{
	my $name = shift;
	
	return unless _is_name $name;

	$name = _format_name $name;

	#not much we can do if they don't pass a proper name
	foreach( keys %names )
		{
		next unless $name eq $names{$_};	
		return $elements{$_}
		}

	return;
	}

sub _get_symbol_by_Z
	{
	my $Z = shift;

	#just in case we were passed a symbol rather
	#then a number
	return unless _is_Z $Z;

	return $elements{$Z} if defined $elements{$Z};

	return;
	}

sub get_name
	{
	my $thingy = shift;

	#since we were asked for a name, we'll suppose that we were passed
	#either a chemical symbol or a Z.
	return _get_name_by_symbol($thingy) if _is_symbol $thingy;
	return _get_name_by_Z($thingy)      if _is_Z $thingy;

	#maybe it's already a name
	return _format_name $thingy if _is_name $thingy;

	#we were passed something wierd.  pretend we don't know anything.
	return;
	}


sub _get_name_by_symbol
	{
	return _get_name_by_Z( _get_Z_by_symbol(shift) );
	}

sub _get_name_by_Z
	{
	my $Z = shift;

	return unless _is_Z $Z;

	#not much we can do if they don't pass a proper number
	if( defined $names{$Z} )
		{
		return $names{$Z};
		}
	
	return;
	}

sub get_Z
	{
	my $thingy = shift;

	#since we were asked for a name, we'll suppose that we were passed
	#either a chemical symbol or a Z.
	return _get_Z_by_symbol($thingy) if _is_symbol $thingy;
	return _get_Z_by_name($thingy)   if _is_name $thingy;

	#maybe it's already a Z
	return $thingy if _is_Z $thingy;

	#we were passed something wierd.  pretend we don't know anything.
	return;
	}

sub _get_Z_by_name
	{
	my $name = shift;
	my ($key, $value);

	while( ($key, $value) = each %names )
		{
		#do a case insensitive match
		if( lc($value) eq lc($name) )
			{
			return $key;
			}
		}

	return;
	}

sub _get_Z_by_symbol
	{
	my $symbol = shift;

	#ensure that the first letter is upper case and that the
	#others are lower case.  this way we can accept data from
	#sources too dumb to know about chemical symbols or proper
	#cases.  (and they exist.  i've seen them.)
	$symbol =~ s/^(.)(.*)$/uc($1).lc($2)/e;

	 if( defined $elements{$symbol} )
		{
		return $elements{$symbol};
		}

	return;
	}

########################################################################
########################################################################
#
# the _is_* functions do some minimal data checking to help other
# functions guess what sort of input they received

########################################################################
sub _is_name
	{
	my $data = shift;

	#at least three alphabetic characters
	return 0 unless $data =~ m/^[a-z][a-z][a-z][a-z]*$/i;

	$data = _format_name $data;

	foreach( keys %names )
		{
		return 1 if $data eq $names{$_};
		}
	
	return 0;
	}

########################################################################
sub _is_symbol
	{
	my $data = shift;

	return 0 unless $data =~ m/^u?[a-z]?[a-z]$/i;

	$data =~ s/^(.)(.*)/uc($1) . lc($2)/e;

	return 1 if defined $elements{$data};

	return 0;
	}

########################################################################
sub _is_Z
	{
	my $data = shift;

	return 0 unless $data =~ m/^1?\d?\d$/;
	return 1 if $data > 0 and $data <= $maximum_Z;
	return 0;
	}

########################################################################
# _format_symbol
#
# input: a string that is supoosedly a chemical symbol
# output: the string with the first character in uppercase and the
#  rest lowercase
#
# there is no data checking involved.  this function doens't know
# and doesn't care if the data are valid.  it just does its thing.
sub _format_symbol
	{
	my $data = shift;
	
	$data =~ s/^(.)(.*)/uc($1).lc($2)/e;

	return $data;
	}

########################################################################
# _format_name
#
# input: a string that is supoosedly a chemical element's name
# output: the string with the first character in uppercase and the
#  rest lowercase
#
# there is no data checking involved.  this function doens't know
# and doesn't care if the data are valid.  it just does its thing.
#
# this looks like _format_symbol, but it logically isn't.  someday
# it might do something different than _format_symbol
sub _format_name
	{
	my $data = shift;
	
	$data =~ s/^(.)(.*)/uc($1).lc($2)/e;

	return $data;
	}

########################################################################
sub AUTOLOAD
	{
	my $self = shift;
	my $data = shift;

	return unless ref $self;

	my $method_name = $AUTOLOAD;

	$method_name =~ s/.*:://;

	if( $data )
		{
		$self->{$method_name} = $data;
		}
	elsif( defined $self->{$method_name} )
		{
		return $self->{$method_name};
		}
	else
		{
		return;
		}
	}

1;

__END__

=head1 NAME

Chemistry::Elements - Perl extension for working with Chemical Elements

=head1 SYNOPSIS

  use Chemistry::Elements qw(get_name get_Z get_symbol);

  # the constructor can use different input
  $element = new Chemistry::Elements $atomic_number;
  $element = new Chemistry::Elements $chemical_symbol;
  $element = new Chemistry::Elements $element_name;

  # you can make up your own attributes by specifying
  # a method (which is really AUTOLOAD)
        $element->molar_mass(22.989) #sets the attribute
  $MM = $element->molar_mass         #retrieves the value

=head1 DESCRIPTION

There are two parts to the module:  the object stuff and the exportable
functions for use outside of the object stuff.  The exportable
functions are discussed in EXPORTABLE FUNCTIONS.

Chemistry::Elements provides an easy, object-oriented way to
keep track of your chemical data.  Using either the atomic
number, chemical symbol, or element name you can construct
an Element object.  Once you have an element object, you can
associate your data with the object by making up your own
methods, which the AUTOLOAD function handles.  Since each
chemist is likely to want to use his or her own data, or
data for some unforesee-able property, this module does not
try to be a repository for chemical data.

The Element object constructor tries to be as flexible as possible -
pass it an atomic number, chemical symbol, or element name and it
tries to create the object.

  # the constructor can use different input
  $element = new Chemistry::Elements $atomic_number;
  $element = new Chemistry::Elements $chemical_symbol;
  $element = new Chemistry::Elements $element_name;

once you have the object, you can define your own methods simply
by using them.  Giving the method an argument (others will be
ignored) creates an attribute with the method's name and
the argument's value.

  # you can make up your own attributes by specifying
  # a method (which is really AUTOLOAD)
        $element->molar_mass(22.989) #sets the attribute
  $MM = $element->molar_mass         #retrieves the value

The atomic number, chemical symbol, and element name can be
retrieved in the same way.

   $atomic_number = $element->Z;
   $name          = $element->name;
   $symbol        = $element->symbol;

These methods can also be used to set values, although changing
any of the three affects the other two.

   $element       = new Chemistry::Elements('Lead');

   $atomic_number = $element->Z;    # $atomic_number is 82

   $element->Z(79);

   $name          = $element->name; # $name is 'Gold'

=head2 Instance methods

=over 4

=item new( Z | SYMBOL | NAME )

Create a new instance from either the atomic number, symbol, or
element name.

=item Z

Return the atomic number of the element.

=item name

Return the name of the element.

=item symbol

Return the symbol of the element.

=back

=head2 Exportable functions

These functions can be exported.  They are not exported by default.

=over 4

=item get_symbol()

This function attempts to return the symbol of the chemical element given
either the chemical symbol, element name, or atmoic number.  The
function does its best to interpret inconsistent input data (e.g.
chemcial symbols of mixed and single case).

	use Chemistry::Elements qw(get_symbol);

	$name = get_symbol('Fe');     #$name is 'Fe'
	$name = get_symbol('fe');     #$name is 'Fe'
	$name = get_symbol(26);       #$name is 'Fe'
	$name = get_symbol('Iron');   #$name is 'Fe'
	$name = get_symbol('iron');   #$name is 'Fe'

If no symbol can be found, nothing is returned.

Since this function will return the symbol if it is given a symbol,
you can use it to test whether a string is a chemical symbol
(although you have to play some tricks with case since get_symbol
will try its best despite the case of the input data).

	if( lc($string) eq lc( get_symbol($string) ) )
		{
		#stuff
		}
	
You can modify the symbols (e.g. you work for UCal ;) ) by changing
the data at the end of this module.

=item get_name()

This function attempts to return the name the chemical element given
either the chemical symbol, element name, or atomic number.  The
function does its best to interpret inconsistent input data (e.g.
chemcial symbols of mixed and single case).

	$name = get_name('Fe');     #$name is 'Iron'
	$name = get_name('fe');     #$name is 'Iron'
	$name = get_name(26);       #$name is 'Iron'
	$name = get_name('Iron');   #$name is 'Iron'
	$name = get_name('iron');   #$name is 'Iron'

If there is no Z can be found, nothing is returned.

Since this function will return the name if it is given a name,
you can use it to test whether a string is a chemical element name
(although you have to play some tricks with case since get_name
will try its best despite the case of the input data).

	if( lc($string) eq lc( get_name($string) ) )
		{
		#stuff
		}

You can modify the names (e.g. for different languages) by changing
the data at the end of this module.

=item get_Z()

This function attempts to return the atomic number of the chemical
element given either the chemical symbol, element name, or atomic
number.  The function does its best to interpret inconsistent input data
(e.g. chemcial symbols of mixed and single case).

	$name = get_Z('Fe');     #$name is 26
	$name = get_Z('fe');     #$name is 26
	$name = get_Z(26);       #$name is 26
	$name = get_Z('Iron');   #$name is 26
	$name = get_Z('iron');   #$name is 26

If there is no Z can be found, nothing is returned.

Since this function will return the Z if it is given a Z,
you can use it to test whether a string is an atomic number.
You might want to use the string comparison in case the
$string is not a number (in which case the comparison
will be false save for the case when $string is undefined).

	if( $string eq get_Z($string) )
		{
		#stuff
		}

=back

The package constructor automatically finds the largest defined
atomic number (in case you add your own heavy elements).

=head2 AUTOLOADing methods

You can pseudo-define additional methods to associate data with objects.
For instance, if you wanted to add a molar mass attribute, you
simply pretend that there is a molar_mass method:

	$element->molar_mass($MM); #add molar mass datum in $MM to object

Similiarly, you can retrieve previously set values by not specifying
an argument to your pretend method:

	$datum = $element->molar_mass();

	#or without the parentheses
	$datum = $element->molar_mass;

If a value has not been associated with the pretend method and the
object, the pretend method returns nothing.

I had thought about providing basic data for the elements, but
thought that anyone using this module would probably have their
own data.  If there is an interest in canned data, perhaps I can
provide mine :)

=head1 TO DO

I would like make this module easily localizable so that one could
specify other names or symbols for the elements (i.e. a different
language or a different perspective on the heavy elements).  If
anyone should make changes to the data, i would like to get a copy
so that i can include it in future releases :)

=head1 COPYRIGHT

Copright 2005, brian d foy

You can use this module under the same terms as Perl itself.

=head1 AUTHOR

brian d foy, CC< <bdfoy@cpan.org> >>

=cut

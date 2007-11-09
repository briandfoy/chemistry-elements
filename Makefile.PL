# $Id$
use ExtUtils::MakeMaker;

eval "use Test::Manifest 1.14";

WriteMakefile(
	'NAME'			=> 'Chemistry::Elements',
	'VERSION_FROM'	=> 'Elements.pm',
	'ABSTRACT'      => 'Perl extension for working with Chemical Elements',
	'LICENSE'		=> 'perl',
	'AUTHOR'        => 'brian d foy <bdfoy@cpan.org>',

	'PM'			=> {
		'Elements.pm'         => '$(INST_LIBDIR)/Elements.pm',
		},

	'PREREQ_PM'     => {
		'Test::More' => 0,
		},
		
	'MAN3PODS'		=> {
		'Elements.pm' => '$(INST_MAN3DIR)/Chemistry::Elements.3',
		},

	clean  => { FILES    => q|Chemistry-Elements-*| },

	);

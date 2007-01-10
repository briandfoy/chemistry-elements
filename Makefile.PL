# $Id$
use ExtUtils::MakeMaker;

eval "use Test::Manifest 1.14";

WriteMakefile(
	'NAME'			=> 'Chemistry::Elements',
	'VERSION_FROM'	=> 'Elements.pm',
	'LICENSE'		=> 'perl',

	'PM'			=> {
		'Elements.pm'         => '$(INST_LIBDIR)/Elements.pm',
		},

	'MAN3PODS'		=> {
		'Elements.pm' => '$(INST_MAN3DIR)/Chemistry::Elements.3',
		},

	clean  => { FILES    => q|Chemistry-Elements-*| },

	);

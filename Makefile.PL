use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Astro::WCS::PP',
    AUTHOR           => q{Piero Ranalli <pranalli.github@gmail.com>},
    VERSION_FROM     => 'lib/Astro/WCS/PP.pm',
    ABSTRACT_FROM    => 'lib/Astro/WCS/PP.pm',
    LICENSE          => 'AGPL',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        #'ABC'              => 1.6,
        #'Foo::Bar::Module' => 5.0401,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'WCS2-*' },
);

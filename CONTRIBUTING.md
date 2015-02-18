# Contributing

See `README.md` for a general introduction.

* <http://github.com/gbv/seealso>: source code repository
* <http://github.com/gbv/seealso/issues>: issue tracker

Relevant source code is located in

* `lib/` - application sources (Perl modules)
* `debian/` - Debian package control files 
    * `changelog` - version number and changes 
      (use `dch` to update)
    * `control` - includes required Debian packages
    * `seealso.default` - default config file 
      (only installed with first installation)
    * `install` - lists which files to install
* `cpanfile` - lists required Perl modules
* `etc/` - default config files
* `htdocs/` - static HTML/CSS/JS/... files

Additional files should not need to be modified unless there is a bug in the
Debian packaging or an upgrade requires some maintainance steps.

Most development tasks are automated in `Makefile`.

First make sure to install required Debian modules:

    $ sudo make dependencies

It is recommended to use the same version of Perl as used on the target
platform (e.g. Perl 5.14 for Ubuntu 12.04), for instance with Perlbrew:

    $ perlbrew use 5.14.4

Install additional Perl modules as listed in `cpanfile` into `local`:

    $ carton install

During development you should locally run the service with automatic restart:

    $ carton exec plackup -Ilib -r --port 6009
    
To run unit tests:

    $ carton exec prove -l

The environment variable `TEST_URL` affects which server the tests are run
against. This can also be used to test an installed service at another host.

Finally build a Debian package for release:

    $ make release-file

The build will produce a valid Debian package but should fail if the git
repository is not clean.

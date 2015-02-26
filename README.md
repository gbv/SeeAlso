# NAME

seealso - SeeAlso server

[![Build Status](https://travis-ci.org/gbv/seealso.svg)](https://travis-ci.org/gbv/seealso)
[![Latest Release](https://img.shields.io/github/release/gbv/seealso.svg)](https://github.com/gbv/seealso/releases)

# DESCRIPTION

**seealso** is a web application that provides SeeAlso link servers.

# SYNOPSIS

The application is automatically started as service, listening on port 6009.

    sudo service seealso {status|start|stop|restart}

# INSTALLATION

The application is packaged as Debian package. No binaries are included, so the
package should work on all architectures. It is tested with Ubuntu 12.04 LTS.

Files are installed at the following locations:

* `/srv/seealso/` - application
* `/var/log/seealso/` - log files
* `/etc/default/seealso` - server configuration
* `/etc/seealso/` - application configuration

# CONFIGURATION

See `/etc/default/seealso` for basic configuration. Settings are not modified
by updates. Restart is needed after changes. Only simple key value-pairs are
allowed with the following keys:

* `PORT` - port number (required, 6009 by default)

* `WORKERS` - number of parallel connections (required, 5 by default). If put 
   behind a HTTP proxy, this number is not affected by slow cient connections 
   but only by the time of processing each request.

Additional configuration is placed in a YAML file in
`/etc/seealso/seealso.yaml`. The following keys are recognized:

* `proxy` - a space-or-comma-separated list of trusted IPs or IP-ranges
   (e.g. `192.168.0.0/16`) to take from the `X-Forwarded-For` header.
   The special value `*` can be used to trust all IPs.

The HTML client can be customized by putting static files into directory
`/etc/seealso/htdocs` to override files in `/srv/seealso/htdocs`.

# SEE ALSO

Changelog is located in `debian/changelog` in the source code repository.

Source code and issue tracker at <https://github.com/gbv/seealso>. See
file `CONTRIBUTING.md` for details.


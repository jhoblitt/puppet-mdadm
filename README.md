Puppet mdadm Module
===================

[![Build Status](https://travis-ci.org/jhoblitt/puppet-mdadm.png)](https://travis-ci.org/jhoblitt/puppet-mdadm)

#### Table of Contents

1. [Overview](#overview)
2. [Description](#description)
3. [Usage](#usage)
    * [Examples](#examples)
    * [Classes](#classes)
    * [Facts](#facts)
4. [Limitations](#limitations)
    * [Tested Platforms](#tested-platforms)
5. [Versioning](#versioning)
6. [Support](#support)
7. [See Also](#see-also)


Overview
--------

Manages the `mdadm` util for Linux software RAID arrays


Description
-----------

This module installs the
[`mdadm`](http://www.linuxfoundation.org/collaborate/workgroups/linux-raid)
package for the management of Linux Software RAID arrays, and provides limited
configuration support.  Specifically, this module does not presently provide
any support for the creation, modification, or removal of `md` arrays.
Management is limited to configuring monitoring of pre-existing `md` arrays,
and array health checks.


Usage
-----

### Examples

#### Simple

```puppet
include ::mdadm
```

#### Set `mdmonitor` email address

```puppet
class { '::mdadm':
  config_file_options => { 'mailaddr' => 'root' },
}
```

### Classes

#### `mdadm`

```puppet
# defaults
class { '::mdadm':
  config_file_manage  => true,
  config_file_options => {},
  force_service       => false,
  service_ensure      => 'running',
  service_enable      => true,
  raid_check_manage   => true
  raid_check_options  => {},
}
```

##### `config_file_manage`

`Bool`  defaults to `true`

Enables/disables management of the `mdadm.conf` configuration file.

##### `config_file_options`

`Hash`  defaults to '{}'

Keyword/value pairs to be set in the `mdadm.conf` configuration file.
Currently, `mailaddr` is the only supported key. Example:

```puppet
  config_file_options => { 'mailaddr' => 'root' },
```

##### `force_service`

`Bool`  defaults to `false`

By default, the `mdadm` class will not attempt to start the `mdmonitor` service
unless the `$::mdadm_arrays` fact lists `md` arrays.  If this parameter is set to `true` the class will always attempt to start the `mdmonitor` service.

##### `service_ensure`

`String`  defaults to 'running'

Sets the state of the `mdmonitor` service.  Valid strings are: 'running',
'stopped'

##### `service_enable`

`Bool`  defaults to 'true'

Enables/disables the `mdmonitor` service on boot.

##### `raid_check_manage`

`Bool`  defaults to `true`

Enables/disables management of the EL specific `raid-check` cron task.

##### `raid_check_options`

`Hash`  defaults to '{}'

Keyword/value pairs to be set in the `/etc/sysconfig/raid-check` configuration
file. Example:

```puppet
  raid_check_options => {
    'ENABLED'       => 'yes',
    'CHECK'         => 'check',
    'NICE'          => 'low',
    'CHECK_DEVS'    => '/dev/md0 /dev/md1',
    'REPAIR_DEVS'   => '/dev/md0',
    'SKIP_DEVS'     => '/dev/md1',
    'MAXCONCURRENT' => '2',
  },
```

### Facts

#### `mdadm`

Path to the `mdadm` executable. Example:

    /sbin/mdadm

#### `mdadmversion`

Version string of the `mdadm` executable. Example:

    v3.2.3

#### `mdadm_arrays`

A listing of `/dev/<foo>` `md` devices. Example:

    /dev/md0,/dev/md1

Limitations
-----------

### Tested Platforms

* el6.x
* el5.x

Versioning
----------

This module is versioned according to the [Semantic Versioning
2.0.0](http://semver.org/spec/v2.0.0.html) specification.


Support
-------

Please log tickets and issues at
[github](https://github.com/jhoblitt/puppet-mdadm/issues)


See Also
--------

* http://www.linuxfoundation.org/collaborate/workgroups/linux-raid
* http://neil.brown.name/blog/mdadm
* https://raid.wiki.kernel.org/index.php/RAID_setup

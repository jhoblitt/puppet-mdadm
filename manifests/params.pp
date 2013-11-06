# == Class: mdadm::params
#
# This class should be considered private.
#
# === Authors
#
# Joshua Hoblitt <jhoblitt@cpan.org>
#
# === Copyright
#
# Copyright (C) 2013 Joshua Hoblitt
#
class mdadm::params {
  case $::osfamily {
    'redhat': {
      $mdadm_package       = 'mdadm'
      $raid_check_path     = '/etc/sysconfig/raid-check'
      $raid_check_template = "${module_name}/redhat/raid-check.el6.erb"
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}

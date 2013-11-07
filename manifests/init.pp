# == Class: mdadm
#
# simple template
#
# === Parameters
#
# All parameteres are optional.
#
# [*raid_check_options*]
#   Hash.  defaults to '{}'
#
# === Examples
#
# include mdadm
#
class mdadm(
  $raid_check_options = {}
) {
  validate_hash($raid_check_options)

  include mdadm::params

  package { $mdadm::params::mdadm_package:
    ensure => present,
  }

  Package[$mdadm::params::mdadm_package] ->
  class { 'mdadm::mdmonitor': }

  Package[$mdadm::params::mdadm_package] ->
  class { 'mdadm::raid_check':
    options => $raid_check_options,
  }
}

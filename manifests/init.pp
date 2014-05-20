# == Class: mdadm
#
# Please refer to https://github.com/jhoblitt/puppet-mdadm#usage for parameter
# documentation.
#
class mdadm(
  $config_options     = {},
  $force_service      = false,
  $service_ensure     = 'running',
  $service_enable     = true,
  $raid_check_options = {},
) {
  validate_hash($config_options)
  validate_bool($force_service)
  validate_re($service_ensure, '^running$|^stopped$')
  validate_bool($service_enable)
  validate_hash($raid_check_options)

  include mdadm::params

  if $::force_service {
    $use_service_ensure = $service_ensure
    $use_service_enable = $service_enable
  } elsif $::mdadm_arrays {
    $use_service_ensure = 'running'
    $use_service_enable = true
  } else {
    $use_service_ensure = 'stopped'
    $use_service_enable = false
  }

  package { $mdadm::params::mdadm_package:
    ensure => present,
  }

  class { 'mdadm::config':
    options => $config_options,
  }

  class { 'mdadm::mdmonitor':
    ensure => $service_ensure,
    enable => $service_enable,
  }

  class { 'mdadm::raid_check':
    options => $raid_check_options,
  }

  anchor { 'mdadm::begin': } ->
  Package[$mdadm::params::mdadm_package] ->
  Class['mdadm::config'] ->
  Class['mdadm::mdmonitor'] ->
  Class['mdadm::raid_check'] ->
  anchor { 'mdadm::end': }
}

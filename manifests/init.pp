# == Class: mdadm
#
# Please refer to https://github.com/jhoblitt/puppet-mdadm#usage for parameter
# documentation.
#
class mdadm(
  Boolean $config_file_manage               = $::mdadm::params::config_file_manage,
  Hash $config_file_options                 = $::mdadm::params::config_file_options,
  Boolean $service_force                    = $::mdadm::params::service_force,
  Enum['running','stopped'] $service_ensure = $::mdadm::params::service_ensure,
  Boolean $service_enable                   = $::mdadm::params::service_enable,
  Boolean $raid_check_manage                = $::mdadm::params::raid_check_manage,
  Hash $raid_check_options                  = $::mdadm::params::raid_check_options,
) inherits mdadm::params {

  if $service_force {
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

  if $config_file_manage {
    Package[$mdadm::params::mdadm_package] ->
    class { 'mdadm::config':
      options => $config_file_options,
    } ->
    Class['mdadm::mdmonitor']
  }

  class { 'mdadm::mdmonitor':
    ensure => $use_service_ensure,
    enable => $use_service_enable,
  }

  if $raid_check_manage {
    Class['mdadm::mdmonitor'] ->
    class { 'mdadm::raid_check':
      options => $raid_check_options,
    } ->
    Anchor['mdadm::end']
  }

  anchor { 'mdadm::begin': } ->
  Package[$mdadm::params::mdadm_package] ->
  Class['mdadm::mdmonitor'] ->
  anchor { 'mdadm::end': }
}

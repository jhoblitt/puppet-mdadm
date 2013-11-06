# == Class: mdadm::raid_check
#
# This class should be considered private.
#
class mdadm::raid_check(
  $options = {}
) {
  include mdadm::params

  # note that 'NICE' is el6.x only

  $default_options = {
    'ENABLED'     => 'yes',
    'CHECK'       => 'check',
    'NICE'        => 'low',
    'CHECK_DEVS'  => '',
    'REPAIR_DEVS' => '',
    'SKIP_DEVS'   => '',
  }

  $safe_options = merge($default_options, $options)

  file { $mdadm::params::raid_check_path:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($mdadm::params::raid_check_template),
  }
}

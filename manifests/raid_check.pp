# == Class: mdadm::raid_check
#
# This class should be considered private.
#
class mdadm::raid_check(
  Hash $options = {}
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $safe_options = merge($::mdadm::raid_check_default_options, $options)

  file { $::mdadm::raid_check_path:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($::mdadm::raid_check_template),
  }
}

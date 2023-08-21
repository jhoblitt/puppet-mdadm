# == Class: mdadm::mdmonitor
#
# This class should be considered private.
#
class mdadm::mdmonitor(
  Enum['running','stopped'] $ensure = 'running',
  Boolean $enable                   = true,
) {

  service { 'mdmonitor':
    ensure     => $ensure,
    hasrestart => true,
    hasstatus  => true,
    enable     => $enable,
  }
}

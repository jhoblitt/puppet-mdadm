# == Class: mdadm::mdmonitor
#
# This class should be considered private.
#
class mdadm::mdmonitor(
  $ensure = 'running',
  $enable = true,
) {
  validate_re($ensure, '^running$|^stopped$')
  validate_bool($enable)

  service { 'mdmonitor':
    ensure     => $ensure,
    hasrestart => true,
    hasstatus  => true,
    enable     => $enable,
  }
}

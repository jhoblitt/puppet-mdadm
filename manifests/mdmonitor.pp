# == Class: mdadm::mdmonitor
#
# This class should be considered private.
#
class mdadm::mdmonitor {
  service { 'mdmonitor':
    ensure     => 'running',
    hasrestart => true,
    hasstatus  => true,
    enable     => true,
  }
}

# == Class: mdadm
#
# simple template
#
# === Examples
#
# include mdadm
#
class mdadm {
  include mdadm::params

  package { $mdadm::params::mdadm_package:
    ensure => present,
  }
}

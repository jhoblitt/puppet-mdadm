# == Class: mdadm::config
#
# This class should be considered private.
#
class mdadm::config(
  $mailaddr = undef,
) {
  validate_string($mailaddr)

  if $mailaddr {
    augeas { 'mdadm.conf mailaddr':
      incl    => '/etc/mdadm.conf',
      lens    => 'Mdadm_conf.lns',
      context => '/files/etc/mdadm.conf',
      changes => "set mailaddr/value '${mailaddr}'",
    }
  }
}

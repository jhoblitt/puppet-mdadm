# == Class: mdadm::params
#
# This class should be considered private.
#
class mdadm::params {
  $config_file_manage = true

  case $::osfamily {
    'redhat': {
      case $::operatingsystemmajrelease {
        6: {
          $mdadm_package       = 'mdadm'
          $raid_check_path     = '/etc/sysconfig/raid-check'
          $raid_check_template = "${module_name}/redhat/raid-check.el6.erb"
        }
        default: {
          fail("Module ${module_name} is not supported on ${::operatingsystem} ${::operatingsystemmajrelease}")
        }
      }
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}

# == Class: gitolite::params
#
# This is a container class with default parameters for gitolite classes.
class gitolite::params {
  $admin_key_content   = undef
  $admin_key_source    = undef
  $allow_local_code    = false
  $git_config_keys     = ''
  $local_code_in_repo  = false
  $local_code_path     = 'local'
  $manage_home_dir     = true
  $manage_user         = true
  $package_ensure      = 'present'
  $repo_specific_hooks = false
  $umask               = '0077'

  # <OS family handling>
  case $::osfamily {
    'Debian': {
      case $::lsbdistcodename {
        'jessie', 'stretch', 'trusty', 'xenial', 'bionic', 'focal': {

        }
        default: {
          fail("gitolite supports Debian 8 (jessie) and 9 (stretch) \
and Ubuntu 14.04 (trusty), 16.04 (xenial), 18.04 (bionic) and 20.04 (focal). \
Detected lsbdistcodename is <${::lsbdistcodename}>.")
        }
      }
    }
    'RedHat': {
      case $::operatingsystemmajrelease {
        '6', '7': {
        }
        default: {
          fail("gitolite supports EL 6 and 7. Detected operatingsystemmajrelease is <${::operatingsystemmajrelease}>.")
        }
      }
    }
    'Suse': {
      $cmd_install  = 'gitolite setup -pk'
      $group_name   = 'git'
      $home_dir     = '/srv/git'
      $package_name = 'gitolite'
      $user_name    = 'git'
    }
    default: {
      fail("gitolite supports osfamilies Debian, RedHat and Suse. Detected osfamily is <${::osfamily}>.")
    }
  }

  if $::osfamily != 'Suse' {
    $cmd_install  = 'gitolite setup -pk'
    $package_name = 'gitolite3'
    $group_name = $package_name
    $home_dir   = "/var/lib/${package_name}"
    $user_name  = $package_name
  }
  # </OS family handling>
}

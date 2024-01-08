# Class: newrelic::agent::dotnet
#
# This class install the New Relic .Net Agent
#
# Parameters:
#
# @param newrelic_dotnet_package_ensure
# @param newrelic_dotnet_conf_dir
# @param newrelic_dotnet_package
# @param newrelic_license_key
# @param newrelic_daemon_cfgfile_ensure
# @param temp_dir
# @param newrelic_dotnet_source
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#  class {'newrelic::agent::dotnet':
#      newrelic_license_key           => 'your license key here',
#      newrelic_dotnet_package_ensure => 'latest',
#    }
#
# If no parameters are set it will use the newrelic.config defaults
#
# For detailed explanation about the parameters below see: https://docs.newrelic.com/docs/php/php-agent-phpini-settings
#
class newrelic::agent::dotnet (
  String $newrelic_dotnet_package_ensure                 = 'present',
  String $newrelic_dotnet_conf_dir                       = $newrelic::params::newrelic_dotnet_conf_dir,
  String $newrelic_dotnet_package                        = $newrelic::params::newrelic_dotnet_package,
  Optional[String] $newrelic_license_key                 = undef,
  String $newrelic_daemon_cfgfile_ensure                 = 'present',
  String $temp_dir                                       = $newrelic::params::temp_dir ,
  String $newrelic_dotnet_source                         = $newrelic::params::newrelic_dotnet_source,
) inherits newrelic {
  if ! $newrelic_license_key {
    fail('You must specify a valid License Key.')
  }

  case $newrelic_dotnet_package_ensure {
    'absent':   {
      $package_source = false
    }
    'present','installed':  {
      $package_source   = "${newrelic_dotnet_source}/NewRelicDotNetAgent_${facts['os']['architecture']}.msi"
      $destination_file = "NewRelicDotNetAgent_${facts['os']['architecture']}.msi"
    }
    'latest':   {
      fail("'latest' is not a valid value for this package, as we have no way of determining which version is the latest one. You can specify a specific version, though.")
    }
    default:    {
      $package_source   = "${newrelic_dotnet_source}/NewRelicDotNetAgent_${facts['os']['architecture']}_${newrelic_dotnet_package_ensure}.msi"
      $destination_file = "NewRelicDotNetAgent_${facts['os']['architecture']}_${newrelic_dotnet_package_ensure}.msi"
    }
  }

  if $package_source {
    download_file { $destination_file:
      url                   => $package_source,
      destination_directory => $temp_dir,
      destination_file      => $destination_file,
      before                => Package[$newrelic_dotnet_package],
    }
  }

  package { $newrelic_dotnet_package:
    ensure  => $newrelic_dotnet_package_ensure,
    source  => "${temp_dir}\\${destination_file}",
    require => Class['newrelic::params'],
  }
  -> file { "${newrelic_dotnet_conf_dir}\\newrelic.config":
    ensure  => $newrelic_daemon_cfgfile_ensure,
    content => template('newrelic/newrelic.config.erb'),
  }
}

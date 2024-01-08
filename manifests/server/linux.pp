# == Class: newrelic::server::linux
#
# This class installs and configures NewRelic server monitoring.
#
# === Parameters
#
# @param newrelic_package_ensure
# @param newrelic_service_enable
# @param newrelic_service_ensure
# @param newrelic_license_key
# @param newrelic_package_name
# @param newrelic_service_name
# @param newrelic_nrsysmond_loglevel
# @param newrelic_nrsysmond_logfile
# @param newrelic_nrsysmond_proxy
# @param newrelic_nrsysmond_ssl
# @param newrelic_nrsysmond_ssl_ca_bundle
# @param newrelic_nrsysmond_ssl_ca_path
# @param newrelic_nrsysmond_pidfile
# @param newrelic_nrsysmond_collector_host
# @param newrelic_nrsysmond_labels
# @param newrelic_nrsysmond_timeout
#
# === Variables
#
# === Examples
#
#  class {'newrelic::server::linux':
#      newrelic_license_key    => 'your license key here',
#      newrelic_package_ensure => 'latest',
#      newrelic_service_ensure => 'running',
#  }
#
# === Authors
#
# Felipe Salum <fsalum@gmail.com>
#
# === Copyright
#
# Copyright 2012 Felipe Salum, unless otherwise noted.
#
class newrelic::server::linux (
  String $newrelic_package_ensure                     = 'present',
  String $newrelic_service_enable                     = 'true',
  String $newrelic_service_ensure                     = 'running',
  Optional[String] $newrelic_license_key              = undef,
  String $newrelic_package_name                       = $newrelic::params::newrelic_package_name,
  String $newrelic_service_name                       = $newrelic::params::newrelic_service_name,
  Optional[String] $newrelic_nrsysmond_loglevel       = undef,
  Optional[String] $newrelic_nrsysmond_logfile        = undef,
  Optional[String] $newrelic_nrsysmond_proxy          = undef,
  Optional[Boolean] $newrelic_nrsysmond_ssl           = undef,
  Optional[String] $newrelic_nrsysmond_ssl_ca_bundle  = undef,
  Optional[String] $newrelic_nrsysmond_ssl_ca_path    = undef,
  Optional[String] $newrelic_nrsysmond_pidfile        = undef,
  Optional[String] $newrelic_nrsysmond_collector_host = undef,
  Optional[String] $newrelic_nrsysmond_labels         = undef,
  Optional[Integer] $newrelic_nrsysmond_timeout       = undef,
) inherits newrelic {
  if ! $newrelic_license_key {
    fail('You must specify a valid License Key.')
  }

  package { $newrelic_package_name:
    ensure  => $newrelic_package_ensure,
    notify  => Service[$newrelic_service_name],
    require => Class['newrelic::params'],
  }

  if ! $newrelic_nrsysmond_logfile {
    $logdir = '/var/log/newrelic'
  } else {
    $logdir = dirname($newrelic_nrsysmond_logfile)
  }

  file { $logdir:
    ensure  => directory,
    owner   => 'newrelic',
    group   => 'newrelic',
    require => Package[$newrelic_package_name],
    before  => Service[$newrelic_service_name],
  }

  file { '/etc/newrelic/nrsysmond.cfg':
    ensure  => file,
    path    => '/etc/newrelic/nrsysmond.cfg',
    content => template('newrelic/nrsysmond.cfg.erb'),
    require => Package[$newrelic_package_name],
    before  => Service[$newrelic_service_name],
    notify  => Service[$newrelic_service_name],
  }

  service { $newrelic_service_name:
    ensure     => $newrelic_service_ensure,
    enable     => $newrelic_service_enable,
    hasrestart => true,
    hasstatus  => true,
    require    => Exec[$newrelic_license_key],
  }

  exec { $newrelic_license_key:
    path    => '/bin:/usr/bin',
    command => "/usr/sbin/nrsysmond-config --set license_key=${newrelic_license_key}",
    user    => 'root',
    group   => 'root',
    unless  => "cat /etc/newrelic/nrsysmond.cfg | grep ${newrelic_license_key}",
    require => Package[$newrelic_package_name],
    notify  => Service[$newrelic_service_name],
  }
}

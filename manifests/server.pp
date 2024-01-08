# == Class: newrelic::server
#
# This class installs and configures NewRelic server monitoring.
#
# === Parameters
#
# @param newrelic_package_ensure
# @param newrelic_service_enable
# @param newrelic_service_ensure
# @param newrelic_license_key
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
#  newrelic::server {
#    'serverXYZ':
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
define newrelic::server (
  String $newrelic_package_ensure                     = 'present',
  String $newrelic_service_enable                     = 'true',
  String $newrelic_service_ensure                     = 'running',
  Optional[String] $newrelic_license_key              = undef,
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
) {
  include newrelic

  $newrelic_package_name = $newrelic::params::newrelic_package_name
  $newrelic_service_name = $newrelic::params::newrelic_service_name

  warning('newrelic::server is deprecated. Please switch to the newrelic::server::linux class.')

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
  }
}

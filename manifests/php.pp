# Class: newrelic::php
#
# This class install the New Relic PHP Agent
#
# Parameters:
#
# @param newrelic_php_package_ensure
# @param newrelic_php_service_ensure
# @param newrelic_php_conf_dir
# @param newrelic_license_key
# @param newrelic_ini_appname
# @param newrelic_ini_browser_monitoring_auto_instrument
# @param newrelic_ini_enabled
# @param newrelic_ini_error_collector_enabled
# @param newrelic_ini_error_collector_prioritize_api_errors
# @param newrelic_ini_error_collector_record_database_errors
# @param newrelic_ini_framework
# @param newrelic_ini_high_security
# @param newrelic_ini_logfile
# @param newrelic_ini_loglevel
# @param newrelic_ini_transaction_tracer_custom
# @param newrelic_ini_transaction_tracer_detail
# @param newrelic_ini_transaction_tracer_enabled
# @param newrelic_ini_transaction_tracer_explain_enabled
# @param newrelic_ini_transaction_tracer_explain_threshold
# @param newrelic_ini_transaction_tracer_record_sql
# @param newrelic_ini_transaction_tracer_slow_sql
# @param newrelic_ini_transaction_tracer_stack_trace_threshold
# @param newrelic_ini_transaction_tracer_threshold
# @param newrelic_ini_capture_params
# @param newrelic_ini_ignored_params
# @param newrelic_daemon_cfgfile_ensure
# @param newrelic_daemon_dont_launch
# @param newrelic_daemon_pidfile
# @param newrelic_daemon_location
# @param newrelic_daemon_logfile
# @param newrelic_daemon_loglevel
# @param newrelic_daemon_port
# @param newrelic_daemon_ssl
# @param newrelic_daemon_ssl_ca_bundle
# @param newrelic_daemon_ssl_ca_path
# @param newrelic_daemon_proxy
# @param newrelic_daemon_collector_host
# @param newrelic_daemon_auditlog
# @param newrelic_php_conf_appname
# @param newrelic_php_conf_enabled
# @param newrelic_php_conf_transaction
# @param newrelic_php_conf_logfile
# @param newrelic_php_conf_loglevel
# @param newrelic_php_conf_browser
# @param newrelic_php_conf_dberrors
# @param newrelic_php_conf_transactionrecordsql
# @param newrelic_php_conf_captureparams
# @param newrelic_php_conf_ignoredparams
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#  newrelic::php {
#    'appXYZ':
#      newrelic_license_key        => 'your license key here',
#      newrelic_php_package_ensure => 'latest',
#      newrelic_php_service_ensure => 'running',
#      newrelic_ini_appname        => 'Your PHP Application',
#    }
#
# If no parameters are set it will use the newrelic.ini defaults
#
# For detailed explanation about the parameters below see: https://docs.newrelic.com/docs/php/php-agent-phpini-settings
#
define newrelic::php (
  String $newrelic_php_package_ensure                                     = 'present',
  String $newrelic_php_service_ensure                                     = 'running',
  Variant[String, Array] $newrelic_php_conf_dir                           = $newrelic::params::newrelic_php_conf_dir,
  Optional[String] $newrelic_license_key                                  = undef,
  Optional[String] $newrelic_ini_appname                                  = undef,
  Optional[Boolean] $newrelic_ini_browser_monitoring_auto_instrument      = undef,
  Optional[Boolean] $newrelic_ini_enabled                                 = undef,
  Optional[Boolean] $newrelic_ini_error_collector_enabled                 = undef,
  Optional[Boolean] $newrelic_ini_error_collector_prioritize_api_errors   = undef,
  Optional[Boolean] $newrelic_ini_error_collector_record_database_errors  = undef,
  Optional[String] $newrelic_ini_framework                                = undef,
  Optional[Boolean] $newrelic_ini_high_security                           = undef,
  Optional[String] $newrelic_ini_logfile                                  = undef,
  Optional[String] $newrelic_ini_loglevel                                 = undef,
  Optional[String] $newrelic_ini_transaction_tracer_custom                = undef,
  Optional[Integer] $newrelic_ini_transaction_tracer_detail               = undef,
  Optional[Boolean] $newrelic_ini_transaction_tracer_enabled              = undef,
  Optional[Boolean] $newrelic_ini_transaction_tracer_explain_enabled      = undef,
  Optional[String] $newrelic_ini_transaction_tracer_explain_threshold     = undef,
  Optional[String] $newrelic_ini_transaction_tracer_record_sql            = undef,
  Optional[Boolean] $newrelic_ini_transaction_tracer_slow_sql             = undef,
  Optional[String] $newrelic_ini_transaction_tracer_stack_trace_threshold = undef,
  Optional[String] $newrelic_ini_transaction_tracer_threshold             = undef,
  Optional[Boolean] $newrelic_ini_capture_params                          = undef,
  Optional[Boolean] $newrelic_ini_ignored_params                          = undef,
  String $newrelic_daemon_cfgfile_ensure                                  = 'present',
  Optional[Integer] $newrelic_daemon_dont_launch                          = undef,
  Optional[String] $newrelic_daemon_pidfile                               = undef,
  Optional[String] $newrelic_daemon_location                              = undef,
  Optional[String] $newrelic_daemon_logfile                               = undef,
  Optional[String] $newrelic_daemon_loglevel                              = undef,
  Optional[Variant[String, Integer]] $newrelic_daemon_port                = undef,
  Optional[Boolean] $newrelic_daemon_ssl                                  = undef,
  Optional[String] $newrelic_daemon_ssl_ca_bundle                         = undef,
  Optional[String] $newrelic_daemon_ssl_ca_path                           = undef,
  Optional[String] $newrelic_daemon_proxy                                 = undef,
  Optional[String] $newrelic_daemon_collector_host                        = undef,
  Optional[String] $newrelic_daemon_auditlog                              = undef,
  Optional[String] $newrelic_php_conf_appname                             = undef,
  Optional[Boolean] $newrelic_php_conf_enabled                            = undef,
  Optional[Integer] $newrelic_php_conf_transaction                        = undef,
  Optional[String] $newrelic_php_conf_logfile                             = undef,
  Optional[String] $newrelic_php_conf_loglevel                            = undef,
  Optional[Boolean] $newrelic_php_conf_browser                            = undef,
  Optional[Boolean] $newrelic_php_conf_dberrors                           = undef,
  Optional[String] $newrelic_php_conf_transactionrecordsql                = undef,
  Optional[Boolean] $newrelic_php_conf_captureparams                      = undef,
  Optional[Boolean] $newrelic_php_conf_ignoredparams                      = undef,
) {
  include newrelic

  $newrelic_php_package  = $newrelic::params::newrelic_php_package
  $newrelic_php_service  = $newrelic::params::newrelic_php_service

  warning('newrelic::php is deprecated. Please switch to the newrelic::agent::php class.')

  if ! $newrelic_license_key {
    fail('You must specify a valid License Key.')
  }

  package { $newrelic_php_package:
    ensure  => $newrelic_php_package_ensure,
    require => Class['newrelic::params'],
    notify  => Service[$newrelic_php_service],
  }

  service { $newrelic_php_service:
    ensure     => $newrelic_php_service_ensure,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

  ::newrelic::php::newrelic_ini { $newrelic_php_conf_dir:
    newrelic_license_key => $newrelic_license_key,
    before               => [File['/etc/newrelic/newrelic.cfg'], Service[$newrelic_php_service]],
    require              => Package[$newrelic_php_package],
    notify               => Service[$newrelic_php_service],
  }

  file { '/etc/newrelic/newrelic.cfg':
    ensure  => $newrelic_daemon_cfgfile_ensure,
    path    => '/etc/newrelic/newrelic.cfg',
    content => template('newrelic/newrelic.cfg.erb'),
    before  => Service[$newrelic_php_service],
    notify  => Service[$newrelic_php_service],
  }

  # Fail on renamed/deprecated variables if they are still used
  if $newrelic_php_conf_appname {
    fail('Variable $newrelic_php_conf_appname is deprecated, use $newrelic_ini_appname instead.')
  }
  if $newrelic_php_conf_browser {
    fail('Variable $newrelic_php_conf_browser is deprecated, use $newrelic_ini_browser_monitoring_auto_instrument instead.')
  }
  if $newrelic_php_conf_captureparams {
    fail('Variable $newrelic_php_conf_captureparams is deprecated, use $newrelic_ini_capture_params instead.')
  }
  if $newrelic_php_conf_dberrors {
    fail('Variable $newrelic_php_conf_dberrors is deprecated, use $newrelic_ini_error_collector_record_database_errors instead.')
  }
  if $newrelic_php_conf_enabled {
    fail('Variable $newrelic_php_conf_enabled is deprecated, use $newrelic_ini_enabled instead.')
  }
  if $newrelic_php_conf_ignoredparams {
    fail('Variable $newrelic_php_conf_ignoredparams is deprecated, use $newrelic_ini_ignored_params instead.')
  }
  if $newrelic_php_conf_logfile {
    fail('Variable $newrelic_php_conf_logfile is deprecated, use $newrelic_ini_logfile instead.')
  }
  if $newrelic_php_conf_loglevel {
    fail('Variable $newrelic_php_conf_loglevel is deprecated, use $newrelic_ini_loglevel instead.')
  }
  if $newrelic_php_conf_transactionrecordsql {
    fail('Variable $newrelic_php_conf_transactionrecordsql is deprecated, use $newrelic_ini_transaction_tracer_record_sql instead.')
  }
  if $newrelic_php_conf_transaction {
    fail('Variable $newrelic_php_conf_transaction is deprecated, use $newrelic_ini_transaction_tracer_detail instead.')
  }
}

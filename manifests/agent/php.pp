# Class: newrelic::agent::php
#
# This class install the New Relic PHP Agent
#
# Parameters:
#
# @param newrelic_php_package_ensure
# @param newrelic_php_service_ensure
# @param newrelic_php_conf_dir
# @param newrelic_php_exec_path
# @param newrelic_php_package
# @param newrelic_php_service
# @param newrelic_license_key
# @param newrelic_ini_appname
# @param newrelic_ini_browser_monitoring_auto_instrument
# @param newrelic_ini_enabled
# @param newrelic_ini_attributes_enabled
# @param newrelic_ini_transaction_events
# @param newrelic_ini_error_collector_enabled
# @param newrelic_ini_error_collector_prioritize_api_errors
# @param newrelic_ini_error_collector_record_database_errors
# @param newrelic_ini_framework
# @param newrelic_ini_high_security
# @param newrelic_ini_labels
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
# @param newrelic_ini_webtransaction_name_files
# @param newrelic_ini_distributed_tracing_enabled
# @param newrelic_daemon_cfgfile_ensure
# @param newrelic_daemon_dont_launch
# @param newrelic_daemon_pidfile
# @param newrelic_daemon_location
# @param newrelic_daemon_logfile
# @param newrelic_daemon_loglevel
# @param newrelic_daemon_port
# @param newrelic_daemon_address
# @param newrelic_daemon_ssl
# @param newrelic_daemon_ssl_ca_bundle
# @param newrelic_daemon_ssl_ca_path
# @param newrelic_daemon_proxy
# @param newrelic_daemon_collector_host
# @param newrelic_daemon_auditlog
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#  class {'newrelic::agent::php':
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
class newrelic::agent::php (
  String $newrelic_php_package_ensure                                     = 'present',
  String $newrelic_php_service_ensure                                     = 'running',
  Variant[String, Array] $newrelic_php_conf_dir                           = $newrelic::params::newrelic_php_conf_dir,
  String $newrelic_php_exec_path                                          = $facts['path'],
  String $newrelic_php_package                                            = $newrelic::params::newrelic_php_package,
  String $newrelic_php_service                                            = $newrelic::params::newrelic_php_service,
  Optional[String] $newrelic_license_key                                  = undef,
  Optional[String] $newrelic_ini_appname                                  = undef,
  Boolean $newrelic_ini_browser_monitoring_auto_instrument                = true,
  Optional[Boolean] $newrelic_ini_enabled                                 = undef,
  Boolean $newrelic_ini_attributes_enabled                                = true,
  Boolean $newrelic_ini_transaction_events                                = true,
  Boolean $newrelic_ini_error_collector_enabled                           = true,
  Optional[Boolean] $newrelic_ini_error_collector_prioritize_api_errors   = undef,
  Optional[Boolean] $newrelic_ini_error_collector_record_database_errors  = undef,
  Optional[String] $newrelic_ini_framework                                = undef,
  Optional[Boolean] $newrelic_ini_high_security                           = undef,
  Optional[String] $newrelic_ini_labels                                   = undef,
  Optional[String] $newrelic_ini_logfile                                  = undef,
  Optional[String] $newrelic_ini_loglevel                                 = undef,
  Optional[String] $newrelic_ini_transaction_tracer_custom                = undef,
  Optional[Integer] $newrelic_ini_transaction_tracer_detail               = undef,
  Boolean $newrelic_ini_transaction_tracer_enabled                        = true,
  Optional[Boolean] $newrelic_ini_transaction_tracer_explain_enabled      = undef,
  Optional[String] $newrelic_ini_transaction_tracer_explain_threshold     = undef,
  Optional[String] $newrelic_ini_transaction_tracer_record_sql            = undef,
  Optional[Boolean] $newrelic_ini_transaction_tracer_slow_sql             = undef,
  Optional[String] $newrelic_ini_transaction_tracer_stack_trace_threshold = undef,
  Optional[String] $newrelic_ini_transaction_tracer_threshold             = undef,
  Optional[Boolean] $newrelic_ini_capture_params                          = undef,
  Optional[Boolean] $newrelic_ini_ignored_params                          = undef,
  Optional[String] $newrelic_ini_webtransaction_name_files                = undef,
  Boolean $newrelic_ini_distributed_tracing_enabled                       = true,
  String $newrelic_daemon_cfgfile_ensure                                  = 'present',
  Optional[Integer] $newrelic_daemon_dont_launch                          = undef,
  Optional[String] $newrelic_daemon_pidfile                               = undef,
  Optional[String] $newrelic_daemon_location                              = undef,
  Optional[String] $newrelic_daemon_logfile                               = undef,
  Optional[String] $newrelic_daemon_loglevel                              = undef,
  Optional[Variant[String, Integer]] $newrelic_daemon_port                = undef,
  Optional[String] $newrelic_daemon_address                               = undef,
  Optional[Boolean] $newrelic_daemon_ssl                                  = undef,
  Optional[String] $newrelic_daemon_ssl_ca_bundle                         = undef,
  Optional[String] $newrelic_daemon_ssl_ca_path                           = undef,
  Optional[String] $newrelic_daemon_proxy                                 = undef,
  Optional[String] $newrelic_daemon_collector_host                        = undef,
  Optional[String] $newrelic_daemon_auditlog                              = undef,
) inherits newrelic {
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
    exec_path                                       => $newrelic_php_exec_path,
    newrelic_license_key                            => $newrelic_license_key,
    newrelic_ini_appname                            => $newrelic_ini_appname,
    newrelic_ini_capture_params                     => $newrelic_ini_capture_params,
    newrelic_ini_labels                             => $newrelic_ini_labels,
    newrelic_daemon_proxy                           => $newrelic_daemon_proxy,
    newrelic_daemon_port                            => $newrelic_daemon_port,
    newrelic_daemon_address                         => $newrelic_daemon_address,
    newrelic_ini_browser_monitoring_auto_instrument => $newrelic_ini_browser_monitoring_auto_instrument,
    newrelic_ini_transaction_tracer_enabled         => $newrelic_ini_transaction_tracer_enabled,
    newrelic_ini_transaction_tracer_detail          => $newrelic_ini_transaction_tracer_detail,
    newrelic_ini_transaction_tracer_record_sql      => $newrelic_ini_transaction_tracer_record_sql,
    newrelic_ini_error_collector_enabled            => $newrelic_ini_error_collector_enabled,
    newrelic_ini_attributes_enabled                 => $newrelic_ini_attributes_enabled,
    newrelic_ini_transaction_events                 => $newrelic_ini_transaction_events,
    newrelic_ini_distributed_tracing_enabled        => $newrelic_ini_distributed_tracing_enabled,
    before                                          => [File['/etc/newrelic/newrelic.cfg'], Service[$newrelic_php_service]],
    require                                         => Package[$newrelic_php_package],
    notify                                          => Service[$newrelic_php_service],
  }

  file { '/etc/newrelic/newrelic.cfg':
    ensure  => $newrelic_daemon_cfgfile_ensure,
    path    => '/etc/newrelic/newrelic.cfg',
    content => template('newrelic/newrelic.cfg.erb'),
    before  => Service[$newrelic_php_service],
    notify  => Service[$newrelic_php_service],
  }
}

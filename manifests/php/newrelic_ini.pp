# This module should not be used directly. It is used by newrelic::php.
#
# @param newrelic_license_key
# @param exec_path
# @param newrelic_ini_appname
# @param newrelic_ini_capture_params
# @param newrelic_ini_labels
# @param newrelic_daemon_proxy
# @param newrelic_daemon_port
# @param newrelic_daemon_address
# @param newrelic_ini_browser_monitoring_auto_instrument
# @param newrelic_ini_transaction_tracer_enabled
# @param newrelic_ini_transaction_tracer_detail
# @param newrelic_ini_transaction_tracer_record_sql
# @param newrelic_ini_error_collector_enabled
# @param newrelic_ini_attributes_enabled
# @param newrelic_ini_transaction_events
# @param newrelic_ini_distributed_tracing_enabled
#
define newrelic::php::newrelic_ini (
  Optional[String] $newrelic_license_key                             = undef,
  String $exec_path                                                  = $facts['path'],
  Optional[String] $newrelic_ini_appname                             = undef,
  Optional[Boolean] $newrelic_ini_capture_params                     = undef,
  Optional[String] $newrelic_ini_labels                              = undef,
  Optional[String] $newrelic_daemon_proxy                            = undef,
  Optional[Variant[String, Integer]] $newrelic_daemon_port           = undef,
  Optional[String] $newrelic_daemon_address                          = undef,
  Optional[Boolean] $newrelic_ini_browser_monitoring_auto_instrument = undef,
  Optional[Boolean] $newrelic_ini_transaction_tracer_enabled         = undef,
  Optional[Integer] $newrelic_ini_transaction_tracer_detail          = undef,
  Optional[String] $newrelic_ini_transaction_tracer_record_sql       = undef,
  Optional[Boolean] $newrelic_ini_error_collector_enabled            = undef,
  Optional[Boolean] $newrelic_ini_attributes_enabled                 = undef,
  Optional[Boolean] $newrelic_ini_transaction_events                 = undef,
  Optional[Boolean] $newrelic_ini_distributed_tracing_enabled        = undef,
) {
  exec { "/usr/bin/newrelic-install ${name}":
    path     => $exec_path,
    command  => "/usr/bin/newrelic-install purge ; NR_INSTALL_SILENT=yes, NR_INSTALL_KEY=${newrelic_license_key} /usr/bin/newrelic-install install",
    provider => 'shell',
    user     => 'root',
    group    => 'root',
    unless   => "grep ${newrelic_license_key} ${name}/newrelic.ini",
  }

  file { "${name}/newrelic.ini":
    path    => "${name}/newrelic.ini",
    content => template('newrelic/newrelic.ini.erb'),
    require => Exec["/usr/bin/newrelic-install ${name}"],
  }
}

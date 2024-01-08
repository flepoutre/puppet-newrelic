# Install New Relic PHP Agent

node default {
  class { 'apache':
    mpm_module => 'prefork',
  }
  class { 'apache::mod::php': }

  class { 'newrelic::server::linux':
    newrelic_license_key => '',
  }

  class { 'newrelic::agent::php':
    newrelic_license_key => '',
    require              => Class['Apache::mod::php'],
  }
}

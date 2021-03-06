class papertrail::install {

  ensure_packages(
    ['rsyslog', 'rsyslog-gnutls', 'wget']
  )

  file { '/etc/rsyslog.d/100-papertrail.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("${module_name}/etc/rsyslog.d/papertrail.conf.erb"),
    require => Package['rsyslog', 'rsyslog-gnutls'],
    notify  => Service['rsyslog'];
  }

  file { $papertrail::cert:
    ensure  => 'present',
    replace => 'no',
    owner   => 'root',
    group   => 'root',
    mode    => '0660',
    require => [
      File['/etc/rsyslog.d/100-papertrail.conf'],
      Exec['get_certificates']
    ];
  }

  exec { 'get_certificates':
    path    => '/bin/:/usr/bin/:/usr/local/bin/',
    command => "wget ${papertrail::cert_url} -O ${papertrail::cert}",
    creates => $papertrail::cert
  }
}

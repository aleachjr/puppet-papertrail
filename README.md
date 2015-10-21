# Puppet Papertrail Module

Module for configuring [Papertrail](https://papertrailapp.com/) with [Rsyslog](http://rsyslog.com/)

## Setup

Nothing more to do than just include it in your node:

```
class { 'papertrail':
  port           => 12345,
  host           => 'logs3.papertrailapp.com'
  optional_files => [
    '/var/log/daemon.log',
    '/var/log/nginx/error.log',
  ]
}
```

### Limitations

This has only been tested on Debian Wheezy.

######################### APM Server Configuration #########################

################################ APM Server ################################

apm-server:
  # Defines the host and port the server is listening on. Use "unix:/path/to.sock" to listen on a unix domain socket.
  host: "0.0.0.0:8200"

  # Enable secure communication between APM agents and the server. By default ssl is disabled.

#================================ Outputs =================================

# Configure the output to use when sending the data collected by apm-server.

#-------------------------- Elasticsearch output --------------------------
output.elasticsearch:
  # Array of hosts to connect to.
  # Scheme and port can be left out and will be set to the default (`http` and `9200`).
  # In case you specify and additional path, the scheme is required: `http://elasticsearch:9200/path`.
  # IPv6 addresses should always be defined as: `https://[2001:db8::1]:9200`.
  hosts: ["${ELASTICSEARCH_HOSTS}"]

  # Boolean flag to enable or disable the output module.
  #enabled: true

  # Set gzip compression level.
  #compression_level: 0

  # Protocol - either `http` (default) or `https`.
  protocol: "https"

  # Authentication credentials - either API key or username/password.
  #api_key: "id:api_key"
  username: ${ELASTICSEARCH_USERNAME}
  password: ${ELASTICSEARCH_PASSWORD}

  # Optional HTTP Path.
  #path: "/elasticsearch"

  # Custom HTTP headers to add to each request.
  #headers:
  #  X-My-Header: Contents of the header

  # Proxy server url.
  #proxy_url: http://proxy:3128

  # The number of times a particular Elasticsearch index operation is attempted. If
  # the indexing operation doesn't succeed after this many retries, the events are
  # dropped. The default is 3.
  #max_retries: 3

  # The number of seconds to wait before trying to reconnect to Elasticsearch
  # after a network error. After waiting backoff.init seconds, apm-server
  # tries to reconnect. If the attempt fails, the backoff timer is increased
  # exponentially up to backoff.max. After a successful connection, the backoff
  # timer is reset. The default is 1s.
  #backoff.init: 1s

  # The maximum number of seconds to wait before attempting to connect to
  # Elasticsearch after a network error. The default is 60s.
  #backoff.max: 60s

  # Configure http request timeout before failing an request to Elasticsearch.
  #timeout: 90

  # The bulk request size threshold, in bytes, before flushing to Elasticsearch.
  # The value must have a suffix, e.g. `"2MB"`. The default is `1MB`.
  #flush_bytes: 1MB

  # The maximum duration to accumulate events for a bulk request before being flushed to Elasticsearch.
  # The value must have a duration suffix, e.g. `"5s"`. The default is `1s`.
  #flush_interval: 1s

  # Enable custom SSL settings. Set to false to ignore custom SSL settings for secure communication.
  #ssl.enabled: true

  # Optional SSL configuration options. SSL is off by default, change the `protocol` option if you want to enable `https`.
  #
  # Control the verification of Elasticsearch certificates. Valid values are:
  # * full, which verifies that the provided certificate is signed by a trusted
  # authority (CA) and also verifies that the server's hostname (or IP address)
  # matches the names identified within the certificate.
  # * strict, which verifies that the provided certificate is signed by a trusted
  # authority (CA) and also verifies that the server's hostname (or IP address)
  # matches the names identified within the certificate. If the Subject Alternative
  # Name is empty, it returns an error.
  # * certificate, which verifies that the provided certificate is signed by a
  # trusted authority (CA), but does not perform any hostname verification.
  #  * none, which performs no verification of the server's certificate. This
  # mode disables many of the security benefits of SSL/TLS and should only be used
  # after very careful consideration. It is primarily intended as a temporary
  # diagnostic mechanism when attempting to resolve TLS errors; its use in
  # production environments is strongly discouraged.
  #ssl.verification_mode: full

  # List of supported/valid TLS versions. By default all TLS versions 1.0 up to
  # 1.2 are enabled.
  #ssl.supported_protocols: [TLSv1.0, TLSv1.1, TLSv1.2]

  # List of root certificates for HTTPS server verifications.
  ssl.certificate_authorities: ["${ELASTICSEARCH_SSL_CERTIFICATEAUTHORITIES}"]

  # Certificate for SSL client authentication.
  #ssl.certificate: "/etc/pki/client/cert.pem"

  # Client Certificate Key
  #ssl.key: "/etc/pki/client/cert.key"

  # Optional passphrase for decrypting the Certificate Key.
  # It is recommended to use the provided keystore instead of entering the passphrase in plain text.
  #ssl.key_passphrase: ''

  # Configure cipher suites to be used for SSL connections.
  #ssl.cipher_suites: []

  # Configure curve types for ECDHE based cipher suites.
  #ssl.curve_types: []

  # Configure what types of renegotiation are supported. Valid options are
  # never, once, and freely. Default is never.
  #ssl.renegotiation: never

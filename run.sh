#!/bin/bash

# Generate config
if [ ! -f /haraka/config/smtp.ini ]; then
  haraka -i /haraka
fi

# Specify hostname
echo $HOSTNAME > /haraka/config/me

if [[ ! -f "/haraka/config/tls_cert.pem" ]] || [[ ! -f "/haraka/config/tls_key.pem" ]]; then
  echo '** [haraka] No TLS Certs Found, Autogenerating Self Signed Certificates'
  cat <<EOF > /tmp/openssl.cnf
[ req ]
default_bits = 1024
encrypt_key = yes
distinguished_name = req_dn
x509_extensions = cert_type
prompt = no

[ req_dn ]
# country (2 letter code)
C=XX

# State or Province Name (full name)
ST=XX

# Locality Name (eg. city)
L=Earth

# Organization (eg. company)
O=Haraka

# Organizational Unit Name (eg. section)
OU=SMTP Server

# Common Name (*.example.com is also possible)
CN=$HOSTNAME

# E-mail contact
emailAddress=postmaster@${HOSTNAME#*.}

[ cert_type ]
nsCertType = server	 	
EOF

  openssl req -new -x509 -nodes -days 365 \
	                -config /tmp/openssl.cnf \
	                -out /haraka/config/tls_cert.pem \
	                -keyout /haraka/config/tls_key.pem
	chmod -R 0600 /certs/*
	rm -rf /tmp/openssl.cnf
fi

haraka -c /haraka

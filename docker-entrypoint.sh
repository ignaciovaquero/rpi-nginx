#!/bin/bash

rm -f /certs/*

cat > /tmp/csr_details.txt <<-EOF
[req]
default_bits = 4096
prompt = no 
default_md = sha256
req_extensions = req_ext
distinguished_name = dn 
 
[ dn ]
C=${NGINX_SERVER_C}
ST=${NGINX_SERVER_ST}
L=${NGINX_SERVER_L}
O=${NGINX_SERVER_O}
OU=${NGINX_SERVER_OU}
emailAddress=${NGINX_SERVER_EMAIL_ADDR}
CN = ${NGINX_SERVER_NAME}
 
[ req_ext ]
subjectAltName = @alt_names
 
[ alt_names ]
DNS.1 = ${NGINX_ALT_NAME}
EOF
  
openssl req -new -sha256 -nodes -out /tmp/certificate.csr -newkey rsa:4096 -keyout /certs/certificate.key -config <( cat /tmp/csr_details.txt )
openssl x509 -signkey /certs/certificate.key -in /tmp/certificate.csr -req -days 365 -out /certs/certificate.crt

sed -i -e 's#<<NGINX_SERVER_NAME>>#'${NGINX_SERVER_NAME}'#g' \
       -e 's#<<NGINX_PROXY_PASS_HOST>>#'${NGINX_PROXY_PASS_HOST}'#g' \
       -e 's#<<NGINX_PROXY_PASS_PORT>>#'${NGINX_PROXY_PASS_PORT}'#g' \
       /etc/nginx/conf.d/nginx.conf

exec nginx -g 'daemon off;'

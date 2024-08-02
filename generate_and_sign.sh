#!/usr/bin/env bash

set -e

cd "${0%/*}"

rm -rf certs
mkdir -p certs
cd certs

# Generate a private key for the CA
openssl genpkey -algorithm RSA -out ca-key.pem

# Generate a self-signed CA certificate
openssl req -new -x509 -days 365 -key ca-key.pem -out ca-cert.pem -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=example.com"

#

# Generate a private key for the Redis server
openssl genpkey -algorithm RSA -out redis-server-key.pem

# Generate a certificate signing request (CSR) for the Redis server
openssl req -new -key redis-server-key.pem -out redis-server.csr -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=redis-server"

# Sign the Redis server certificate with the CA certificate
openssl x509 -req -in redis-server.csr -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out redis-server-cert.pem -days 365

#

# Generate a private key for the redis-py client
openssl genpkey -algorithm RSA -out redis-client-key.pem

# Generate a certificate signing request (CSR) for the redis-py client
openssl req -new -key redis-client-key.pem -out redis-client.csr -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=redis-client"

# Sign the redis-py client certificate with the CA certificate
openssl x509 -req -in redis-client.csr -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out redis-client-cert.pem -days 365

#

# Generate a private key for the self-signed redis-py client
openssl genpkey -algorithm RSA -out self-signed-client-key.pem

# Generate a self-signed certificate for the redis-py client
openssl req -new -x509 -days 365 -key self-signed-client-key.pem -out self-signed-client-cert.pem -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=self-signed-client"

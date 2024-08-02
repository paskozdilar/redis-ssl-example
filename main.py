#!/usr/bin/env python3

import random
import redis


def main():
    try:
        test_client_valid()
    except Exception as exc:
        print('error:', exc)
    else:
        print('ok')

    print()

    try:
        test_client_self_signed()
    except Exception as exc:
        print('error:', exc)
    else:
        print('ok')

    print()

    try:
        test_client_no_certificate()
    except Exception as exc:
        print('error:', exc)
    else:
        print('ok')


def test_client_valid():
    """ Connect to redis using valid server-signed credentials """

    print("test client valid")
    r = redis.Redis(
        host='localhost',
        port=6379,

        ssl=True,
        ssl_ca_certs='certs/ca-cert.pem',
        ssl_certfile='certs/redis-client-cert.pem',
        ssl_keyfile='certs/redis-client-key.pem',
    )
    d = random.randbytes(1024)
    r.set(b'key', d)
    v = r.get('key')
    assert v == d


def test_client_self_signed():
    """ Connect to redis using self-signed credentials """

    print("test client self-signed")
    r = redis.Redis(
        host='localhost',
        port=6379,

        ssl=True,
        ssl_ca_certs='certs/ca-cert.pem',
        ssl_certfile='certs/self-signed-client-cert.pem',
        ssl_keyfile='certs/self-signed-client-key.pem',
    )
    d = random.randbytes(1024)
    r.set(b'key', d)
    v = r.get('key')
    assert v == d


def test_client_no_certificate():
    """ Connect to redis without client certificate """

    print("test client no certificate")
    r = redis.Redis(
        host='localhost',
        port=6379,

        ssl=True,
        ssl_ca_certs='certs/ca-cert.pem',
    )
    d = random.randbytes(1024)
    r.set(b'key', d)
    v = r.get('key')
    assert v == d


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        pass

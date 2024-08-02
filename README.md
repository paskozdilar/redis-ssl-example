# redis-ssl-example

Setup used to test Redis client-side SSL verification.

## running

Start Redis server:

```bash
docker compose up --build --detach
```

Then run testing script:

```bash
python3 main.py
```

## certs

Certificates are generated using the shell script:

```bash
bash generate_and_sign.sh
```

After re-generating the certificates, docker container must be rebuilt to apply
new certificates.

# Hashicorp Vault

The Vault infrastructure is deployed using Docker Compose. It currently consists of:

- Postgreql storage
- Single Vault
- Nginx Reverse Proxy

Please note that this is a development enviroment and this config should not be used in production.

## Deploy Vault

Make sure you have created some certificates using `openssl` in the `configuration/certs` directory.

```ssh
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./vault.key -out ./vault.crt
```

In order to provide connection details for the database. I use [direnv](https://github.com/direnv/direnv) to auto-load environment variables.

The following variables are used:

- POSTGRES_USER=${PGUSER}
- POSTGRES_PASSWORD=${PGPASSWORD}
- POSTGRES_DB=${PGDATABASE}
- POSTGRES_URL=${PGURL}

Next you should be able to start the stack using the following command:

```ssh
docker compose -f src/infrastructure/docker-compose.yaml -d
```

At the end of the logs you should see a message like this:

```
vault        | ==> Vault server configuration:
vault        |
vault        |              Api Address: http://0.0.0.0:8200
vault        |                      Cgo: disabled
vault        |          Cluster Address: https://0.0.0.0:8201
vault        |    Environment Variables: GODEBUG, HOME, HOSTNAME, PATH, PWD, SHLVL, VAULT_LOCAL_CONFIG
vault        |               Go Version: go1.20.4
vault        |               Listener 1: tcp (addr: "0.0.0.0:8200", cluster address: "0.0.0.0:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
vault        |                Log Level:
vault        |                    Mlock: supported: true, enabled: true
vault        |            Recovery Mode: false
vault        |                  Storage: postgresql (HA available)
vault        |                  Version: Vault v1.13.3, built 2023-06-06T18:12:37Z
vault        |              Version Sha: 3bedf816cbf851656ae9e6bd65dd4a67a9ddff5e
vault        |
vault        | 2024-08-05T19:47:55.299Z [INFO]  proxy environment: http_proxy="" https_proxy="" no_proxy=""
vault        | 2024-08-05T19:47:55.517Z [INFO]  core: Initializing version history cache for core
vault        | ==> Vault server started! Log data will stream in below:
vault        |
vault        | 2024-08-05T19:48:03.548Z [INFO]  core: security barrier not initialized
vault        | 2024-08-05T19:48:03.548Z [INFO]  core: seal configuration missing, not initialized
```

You also should be able to access the Vault UI on: https://0.0.0.0/ui or the provided server name in the Nginx config.

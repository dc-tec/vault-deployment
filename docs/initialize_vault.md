# Initialize Vault

After starting up the stack, Vault needs to be initialized. Make sure you have the Vault CLI tooling installed on your system.

Run the following command to initialize vault.

`vault operator init`

You should get back the following type of output:

```
Unseal Key 1: < KEY1 >
Unseal Key 2: < KEY2 >
Unseal Key 3: < KEY3 >
Unseal Key 4: < KEY4 >
Unseal Key 5: < KEY5 >

Initial Root Token: < INITIAL ROOT TOKEN >

Vault initialized with 5 key shares and a key threshold of 3. Please securely
distribute the key shares printed above. When the Vault is re-sealed,
restarted, or stopped, you must supply at least 3 of these keys to unseal it
before it can start servicing requests.

Vault does not store the generated root key. Without at least 3 keys to
reconstruct the root key, Vault will remain permanently sealed!

It is possible to generate new unseal keys, provided you have a quorum of
existing unseal keys shares. See "vault operator rekey" for more information.
```

Make note of the unseal keys and the initial root token. Please note that the initial root token needs to be revoked later.

It is now possible to unseal the vault using the following command, using the default initialization config we need a minimum of 3 keys to unseal the vault.

```ssh
vault operator unseal $VAULT_1
vault operator unseal $VAULT_2
vault operator unseal $VAULT_3
```

You should receive the following kind of output:

```
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    5
Threshold       3
Version         1.13.3
Build Date      2023-06-06T18:12:37Z
Storage Type    postgresql
Cluster Name    dev-vault-cls
Cluster ID      aea6bcc1-56ea-80df-8a4c-14458fd253fe
HA Enabled      true
HA Cluster      https://0.0.0.0:8201
HA Mode         active
Active Since    2024-08-05T20:17:49.992538402Z
```

After unsealing it is possible to authenticate with the initial root token:

`vault login $VAULT_TOKEN`

The following type of output needs to be received:

```
Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                  Value
---                  -----
token                $VAULT_TOKEN
token_accessor       8HUlu4uiomdZhirf1YKJcpa1
token_duration       ∞
token_renewable      false
token_policies       ["root"]
identity_policies    []
policies             ["root"]
```

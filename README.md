# Clinical Genetics - Deployment tools

All systems are managed using ansible.


## Installation

Install required ansible roles and collections using:

```
ansible-galaxy install -r requirements.yaml
```

### Basic usage

Some common commmands are provided in the [justfile](https://github.com/casey/just).

Main deployment entrypoint:

```
$ just play site
```

Edit secrets (stored in vaulted secrets)

```
$ just vedit
```

## Overview of services

### baserow

The baserow role `./roles/baserow` provides tasks and templates for deploying a
baserow installation using docker compose.

The role depends on the [certs](##Managing server certificates) rule, which will automatically fetch certificates
for the given host. This will require key id and hmac key to be defined for the
individual host. These should stay private and should be best kept in a vaulted
file.

### freescout

The freescout role `./roles/freescout` is analogous to the baserow role, but
just provides a different docker compose template currently.

### [webrelay](https://github.com/xiamaz/webrelay)

This service provides access to certain variant analysis platforms, such as
HGMD, as the Charité IP is changing.

### [baserow synchronization](https://github.com/xiamaz/cads_data_exchange)

This repository provides automated scripts to synchronize services with other
tools and services.

### [automated report generation](https://github.com/xiamaz/clinical-report-templating)

This repository provides tools to automatically generate docx based reports for
medgen.

## Secrets management

All secrets should be encrypted and decrypted using Ansible vault files. The
commands in the justfile can be used for simplicity sake.

Editing a vaulted file:

```
$ just vedit <path to file>
```

Creating a vaulted file:

```
# write a file with secret content at <path>
$ just venc <path>
```

Decrypt a vaulted file (this will make the file plaintext!):

```
$ just vdenc <path>
```

### Managing server access passwords

These are current set in `vault.yml` files in the `host_vars` directory.


### Managing tokens and other secrets necessary for deployment

These should be managed via `group_vars`.

### Managing server certificates

Automatic retrieval of ACME certificates is integrated in the certs role. Refer
to the defaults vars to see which variables are needed.

Currently the variables are mostly setup through vaulted host vars and the
application specific `application_name` is set through a dependency var. The
certs role should only be used as a dependency for another deployment that
requires SSL certificates.

Refer to the `baserow` role to see how it is used in action.

Using the role on a new host will require a key id and hmac key for certbot.
These can be obtained through [netz-pki](https://netz-pki.charite.de/) at
Charité.

### Issues with copying templates as unprivileged users

Make sure `acl` is installed on the server. Sometimes will might require some
form of reboot.

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

### [baserow](https://github.com/xiamaz/phenotips-gc)

This provides the no-code database, which is used to track samples and
diagnostic status across Medgen and contains links and integrations provided
below.

### [freescout](https://github.com/xiamaz/freescout-charite)

This provides a web tool for managing email-based tickets, which is used by the
genomics department to track external requests and assign these to clinicians.

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

### Issues with copying templates as unprivileged users

Make sure `acl` is installed on the server. Sometimes will might require some
form of reboot.

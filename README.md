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

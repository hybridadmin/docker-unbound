# Unbound DNS Server Docker Image with DNSBL

![ci](https://github.com/hybridadmin/docker-unbound/workflows/ci/badge.svg?branch=main) ![Docker Pulls](https://img.shields.io/docker/pulls/hybridadmin/unbound)

## Supported tags and respective `Dockerfile` links

- [`1.13.0`, `latest`](https://github.com/hybridadmin/docker-unbound/tree/main/1.13.0/Dockerfile)
- [`1.12.0`](https://github.com/hybridadmin/docker-unbound/tree/main/1.12.0/Dockerfile)

## What is Unbound?

Unbound is a validating, recursive, and caching DNS resolver.
> [unbound.net](https://unbound.net/)

## How to use this image

### Standard usage

Run this container with the following command:

```console
docker run --name my-unbound -d -p 53:53/udp -p 53:53/tcp --restart=always hybridadmin/unbound:latest
```

To run older versions use the version tag for the required container image, i.e for version 1.12.0, run the following command:

```console
docker run --name my-unbound -d -p 53:53/udp -p 53:53/tcp --restart=always hybridadmin/unbound:1.12.0
```


### DNSBL support

By default, DNSBL support is added by generating a unbound_blacklist.conf and unbound_whitelist.conf in "/opt/unbound/etc/unbound" using the script [unbound_dnsbl.sh](unbound_dnsbl.sh). These 2 files have been
included in the unbound config file `/opt/unbound/etc/unbound/unbound.conf` using the "include:" option in the container as below.

Example `unbound.conf`:
```
server:
...
    include: /opt/unbound/etc/unbound/unbound_blocklist.conf
    include: /opt/unbound/etc/unbound/unbound_whitelist.conf
```

The blacklists/whitelists used are from the [Aha.Dns.Domains](https://github.com/AhaDNS/Aha.Dns.Domains) repo and used in production by their [AhaDNS](https://ahadns.com/) service.



# User feedback

## Documentation

Documentation for Unbound is available on the [project's website](https://unbound.net/).

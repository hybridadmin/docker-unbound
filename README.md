# Unbound DNS Server Docker Image with DNSBL

## Supported tags and respective `Dockerfile` links

- [`1.13.0`, `latest` (*1.13.0/Dockerfile*)](https://github.com/hybridadmin/docker-unbound/tree/main/1.13.0/Dockerfile)
- [`1.12.0`, (*1.12.0/Dockerfile*)](https://github.com/hybridadmin/docker-unbound/tree/main/1.12.0/Dockerfile)

## What is Unbound?

Unbound is a validating, recursive, and caching DNS resolver.
> [unbound.net](https://unbound.net/)

## How to use this image

### Standard usage

Run this container with the following command:

```console
docker run --name my-unbound -d -p 53:53/udp -p 53:53/tcp \
--restart=always hybridadmin/unbound:latest
```

### Override default forward

By default, DNSBL support is added by generating a unbound_blacklist.conf and unbound_whitelist.conf in "/opt/unbound/etc/unbound" using the script [1.13.0/unbound_dnsbl.sh](1.13.0/unbound_dnsbl.sh). These 2 files have been 

included in the unbound config file `/opt/unbound/etc/unbound/unbound.conf` using the "include:" option in the container as below.

Example `unbound.conf`:
```
server:
...
    include: /opt/unbound/etc/unbound/unbound_blocklist.conf
    include: /opt/unbound/etc/unbound/unbound_whitelist.conf
```


# User feedback

## Documentation

Documentation for Unbound is available on the [project's website](https://unbound.net/).


## Licenses

### License

Unless otherwise specified, all code is released under the MIT License (MIT).
See the [repository's `LICENSE`
file](https://github.com/hybridadmin/docker-unbound/blob/master/LICENSE) for
details.

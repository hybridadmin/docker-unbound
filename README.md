# Unbound DNS Server Docker Image with DNSBL

![ci](https://github.com/hybridadmin/docker-unbound/workflows/ci/badge.svg?branch=main) ![Docker Pulls](https://img.shields.io/docker/pulls/hybridadmin/unbound)

## Supported tags and respective `Dockerfile` links

- [`1.13.2`, `latest`](https://github.com/hybridadmin/docker-unbound/tree/main/1.13.2/Dockerfile)
- [`1.13.1`](https://github.com/hybridadmin/docker-unbound/tree/main/1.13.1/Dockerfile)
- [`1.13.0`](https://github.com/hybridadmin/docker-unbound/tree/main/1.13.0/Dockerfile)
- [`1.12.0`](https://github.com/hybridadmin/docker-unbound/tree/main/1.12.0/Dockerfile)

## What is Unbound?

Unbound is a validating, recursive, and caching DNS resolver.
> [`unbound.net`](https://unbound.net/)

## Usage

### docker-compose
```yaml
---
version: "3.2"
services:
  unbound:
    image: hybridadmin/unbound:latest
    container_name: unbound
    hostname: unbound-server #optional
    environment:
      - LISTEN_ADDR
      - CACHE_MAX_TTL=86400 #optional
      - CACHE_MIN_TTL=300 #optional
      - EDNS_BUFFER_SIZE=1232 #optional
      - RRSET_ROUNDROBIN=yes #optional
      - LOG_VERBOSITY=0 #optional
      - AGGRESSIVE_NSEC=yes #optional
      - DO_NOT_QUERY_LOCALHOST=yes #optional
      - NEG_CACHE_SIZE_MB=4 #optional
      - QNAME_MINIMISATION=yes #optional
      - DENY_ANY=yes #optional
      - HARDEN_BELOW_NXDOMAIN=yes #optional
      - HARDEN_DNSSEC_STRIPPED=yes #optional
      - HARDEN_GLUE=yes #optional
      - HARDEN_LARGE_QUERIES=yes #optional
      - HIDE_IDENTITY=yes #optional
      - HIDE_VERSION=yes #optional
      - UNWANTED_REPLY_THRESHOLD=10000 #optional
      - USE_CAPS_FOR_ID=yes #optional
      - VAL_CLEAN_ADDITIONAL=yes #optional
      - NUM_QUERIES_PER_THREAD=4096 #optional
      - OUTGOING_RANGE=8192 #optional
      - MINIMAL_RESPONSES=yes #optional
      - CONTROL_ENABLE=yes #optional
    ports:
      - 53:53/tcp
      - 53:53/udp
    restart: always
```

### docker cli

Run a container with the default settings:

```console
docker run -d --name unbound -p 53:53/udp -p 53:53/tcp --restart=always hybridadmin/unbound:latest
```

Run a container with customized settings:

```console
docker run -d --name unbound \
-e LISTEN_ADDR
-e CACHE_MAX_TTL=86400 #optional \
-e CACHE_MIN_TTL=300 #optional \
-e EDNS_BUFFER_SIZE=1232 #optional \
-e RRSET_ROUNDROBIN=yes #optional \
-e LOG_VERBOSITY=0 #optional \
-e AGGRESSIVE_NSEC=yes #optional \
-e DO_NOT_QUERY_LOCALHOST=yes #optional \
-e NEG_CACHE_SIZE_MB=4 #optional \
-e QNAME_MINIMISATION=yes #optional \
-e DENY_ANY=yes #optional \
-e HARDEN_BELOW_NXDOMAIN=yes #optional \
-e HARDEN_DNSSEC_STRIPPED=yes #optional \
-e HARDEN_GLUE=yes #optional \
-e HARDEN_LARGE_QUERIES=yes #optional \
-e HIDE_IDENTITY=yes #optional \
-e HIDE_VERSION=yes #optional \
-e UNWANTED_REPLY_THRESHOLD=10000 #optional \
-e USE_CAPS_FOR_ID=yes #optional \
-e VAL_CLEAN_ADDITIONAL=yes #optional \
-e NUM_QUERIES_PER_THREAD=4096 #optional \
-e OUTGOING_RANGE=8192 #optional \
-e MINIMAL_RESPONSES=yes #optional \
-e CONTROL_ENABLE=yes #optional \
-p 53:53/udp -p 53:53/tcp --restart=always hybridadmin/unbound:1.12.0
```


## DNSBL support

By default, DNSBL support is added by generating a `unbound_blacklist.conf` and `unbound_whitelist.conf` in "/opt/unbound/etc/unbound" using the script [`unbound_dnsbl.sh`](unbound_dnsbl.sh). These 2 files have been
included in the unbound config file `/opt/unbound/etc/unbound/unbound.conf` using the "include:" option in the container as below.

Example `unbound.conf`:
```
server:
...
    include: /opt/unbound/etc/unbound/unbound_blocklist.conf
    include: /opt/unbound/etc/unbound/unbound_whitelist.conf
```

The blacklists/whitelists used are from the [`Aha.Dns.Domains`](https://github.com/AhaDNS/Aha.Dns.Domains) repo and used in production by their [`AhaDNS`](https://ahadns.com/) service.


## Configuration settings

The configuration settings used inside the container can be found at the link below:
[`unbound.conf`](https://www.nlnetlabs.nl/documentation/unbound/unbound.conf/)


## Environment Variables

| Variable | Function |
| :----: | --- |
| `LISTEN_ADDR` | The address(es) that unbound should bind to |
| `CACHE_MAX_TTL` | Time to live maximum for RRsets and messages in the cache |
| `CACHE_MIN_TTL` | Time to live minimum for RRsets and messages in the cache |
| `EDNS_BUFFER_SIZE` | Number  of bytes size to advertise as the EDNS reassembly buffer size |
| `RRSET_ROUNDROBIN` | Number of bytes size of the RRset cache |
| `LOG_VERBOSITY` | The log verbosity number. 0 - 5 |
| `AGGRESSIVE_NSEC` | Use the DNSSEC NSEC chain to synthesize NXDO-MAIN and other denials, using info from previous NXDO-MAINs answers |
| `DO_NOT_QUERY_LOCALHOST` | To not answer queries on localhost |
| `NEG_CACHE_SIZE_MB` | Number of Mbytes size of the aggressive negative cache |
| `QNAME_MINIMISATION` | Send minimum amount of information to upstream servers to enhance privacy |
| `DENY_ANY` | Deny queries of type ANY with an empty response |
| `HARDEN_BELOW_NXDOMAIN` | Return nxdomain to queries for a name below another name that is already known to be nxdomain (RFC 8020) |
| `HARDEN_DNSSEC_STRIPPED` | Require DNSSEC data for trust-anchored zones, if such data is absent, the zone becomes bogus |
| `HARDEN_GLUE` | Will trust glue only if it is within the servers authority |
| `HARDEN_LARGE_QUERIES` | Ignore Very large queries |
| `HIDE_IDENTITY` | Refuse id.server and hostname.bind queries |
| `HIDE_VERSION` | Refuse version.server and version.bind queries |
| `UNWANTED_REPLY_THRESHOLD` | Total number of unwanted replies to keep track of in every thread |
| `USE_CAPS_FOR_ID` | Use 0x20-encoded random bits in the query to foil spoof attempts |
| `VAL_CLEAN_ADDITIONAL` | Instruct the validator to remove data from the additional section of secure messages that are not signed properly |
| `NUM_QUERIES_PER_THREAD` | The number of queries that every thread will service simultane-ously |
| `OUTGOING_RANGE` | Number of ports to open |
| `MINIMAL_RESPONSES` | Dont insert authority/additional sections into response messages when those sections are not required |
| `CONTROL_ENABLE` | Enable remote control |

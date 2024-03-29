![Build and Push](https://github.com/binbashing/owasp-crs-ngxblocker/actions/workflows/merge-build-push.yaml/badge.svg)

# owasp-crs-ngxblocker
OWASP ModSecurity Core Rule Set for NGINX with Ultimate Bad Bot Blocker 

This repository contains Docker images that combine the [Official ModSecurity Docker + Core Rule Set (CRS) images](https://github.com/coreruleset/modsecurity-crs-docker) for NGINX with the ['NGINX Ultimate Bad Bot Blocker'](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker). 

## About the Images

The images are built on top of the official ModSecurity Docker images for NGINX, which provide a powerful, open-source, cross-platform web application firewall (WAF) engine. The Core Rule Set (CRS) provides a set of generic attack detection rules that provide a base level of protection for any web application.

The images also include the NGINX Ultimate Bad Bot Blocker, a set of configurations for NGINX that block a large number of bad bots, crawlers, scrapers, and other malicious actors.

## Usage

To use these images, you can pull them from Docker Hub:

```bash
docker pull binbashing/owasp-crs-ngxblocker:nginx
docker pull binbashing/owasp-crs-ngxblocker:nginx-alpine
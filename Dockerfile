FROM owasp/modsecurity-crs:nginx

ADD https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker /usr/local/sbin/install-ngxblocker

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y dnsutils wget && \
    cd /usr/local/sbin/ && \
    chmod 777 install-ngxblocker && \    
    ./install-ngxblocker -x && \
    ./setup-ngxblocker -x -e conf -v /etc/nginx/conf.d/ && \
    chown nginx:root /etc/nginx/conf.d/* && \
    chown nginx:root /etc/nginx/bots.d/* && \
    chmod 664 /etc/nginx/bots.d/* && \
    chmod 664 /etc/nginx/conf.d/*

USER nginx
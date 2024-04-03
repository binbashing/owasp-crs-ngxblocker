FROM owasp/modsecurity-crs:nginx

ADD https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker /usr/local/sbin/install-ngxblocker

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y dnsutils wget

RUN cd /usr/local/sbin/ && \
    chmod 777 install-ngxblocker && \    
    ./install-ngxblocker -x && \
    chmod 777 *-ngxblocker

RUN setup-ngxblocker -x -e template -v /etc/nginx/templates/conf.d/ -c /etc/nginx/templates/conf.d -m /etc/nginx/templates/nginx.conf.template && \
    chown nginx:nginx /etc/nginx/conf.d/* && \
    chown nginx:nginx /etc/nginx/bots.d/* && \
    chmod 664 /etc/nginx/bots.d/* && \
    chmod 664 /etc/nginx/conf.d/*

USER nginx
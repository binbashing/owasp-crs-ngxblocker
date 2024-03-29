# Start from the owasp/modsecurity-crs:nginx image
FROM owasp/modsecurity-crs:nginx

# Add the install-ngxblocker script from the nginx-ultimate-bad-bot-blocker project
ADD https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker /usr/local/sbin/install-ngxblocker

# Switch to the root user to install packages and modify file permissions
USER root

# Update the package list, upgrade all packages, and install dnsutils and wget
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y dnsutils wget && \
    # Change to the /usr/local/sbin directory
    cd /usr/local/sbin/ && \
    # Make the install-ngxblocker script executable
    chmod 777 install-ngxblocker && \    
    # Run the install-ngxblocker script with the -x (execute) option
    ./install-ngxblocker -x && \
    # Run the setup-ngxblocker script with the -x (execute), -e (edit configuration), and -v (verbose) options
    # The configuration files will be placed in /etc/nginx/conf.d/
    ./setup-ngxblocker -x -e conf -v /etc/nginx/conf.d/ && \
    # Change the owner of the configuration files to nginx:root
    chown nginx:root /etc/nginx/conf.d/* && \
    chown nginx:root /etc/nginx/bots.d/* && \
    # Change the permissions of the configuration files to 664 (read and write for owner and group, read for others)
    chmod 664 /etc/nginx/bots.d/* && \
    chmod 664 /etc/nginx/conf.d/*

# Switch back to the nginx user for security
USER nginx
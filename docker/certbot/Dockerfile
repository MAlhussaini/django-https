FROM certbot/certbot:v1.27.0

COPY certify-init.sh /opt/
# To make the script excutable
RUN chmod +x /opt/certify-init.sh

# Empty list to override the entrypoint
ENTRYPOINT []
# The certbot will always be used for renewing certificates
CMD ["certbot", "renew"]

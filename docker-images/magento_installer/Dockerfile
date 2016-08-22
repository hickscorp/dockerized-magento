FROM magento_php

COPY files /

RUN set -x && \
    curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/bin && \
    chmod +x /bin/substitute-env-vars.sh /bin/install.sh

ENTRYPOINT ["/bin/install.sh"]

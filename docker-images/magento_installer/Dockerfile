FROM doodloo/magento_php
MAINTAINER Pierre Martin <HicksCorp@GMail.com>

COPY files /

RUN set -ex && \
  curl -O https://files.magerun.net/n98-magerun.phar &&\
  chmod +x n98-magerun.phar &&\
  mv n98-magerun.phar /usr/local/bin/magerun &&\
  chmod +x /bin/substitute-env-vars.sh /bin/install.sh

ENTRYPOINT ["/bin/install.sh"]

#!/usr/bin/env bash

case "$1" in
  "start")
    case "$2" in
      "staging")
        DOMAIN=mage.snappic.io \
        SNAPPIC_API_HOST=http://api.staging.snappic.io \
        SNAPPIC_ADMIN_URL=http://www.staging.snappic.io \
        SNAPPIC_STORE_ASSETS_HOST=http://store.staging.snappic.io \
        ./magento start
        ;;
      "production")
        DOMAIN=mage.snappic.io \
        SNAPPIC_API_HOST=http://api.staging.snappic.io \
        SNAPPIC_ADMIN_URL=http://www.staging.snappic.io \
        SNAPPIC_STORE_ASSETS_HOST=http://store.staging.snappic.io \
        ./magento start
        ;;
      "development")
        DOMAIN=dockerized-magento.local \
        SNAPPIC_API_HOST=http://localhost:3000 \
        SNAPPIC_ADMIN_URL=http://localhost:4200 \
        SNAPPIC_STORE_ASSETS_HOST=http://store.staging.snappic.io \
        ./magento start
        ;;
      *)
        echo "Please specify either one of [staging|production|development]."
      ;;
    esac
  ;;

  "stop")
    ./magento stop
  ;;

  "destroy")
    DOMAIN=none \
    SNAPPIC_API_HOST=none \
    SNAPPIC_ADMIN_URL=none \
    SNAPPIC_STORE_ASSETS_HOST=none \
    ./magento stop
    docker rm -f `docker ps -aq`
    sudo rm -rf data/mysql \
                data/logs/* \
                data/root/web \
                data/root/vendor \
                data/root/composer.lock
esac

#!/bin/bash

if [ -z "$MAGENTO_ROOT" ]
then
	echo "Please specify the root directory of Magento via the environment variable: MAGENTO_ROOT"
	exit 1
fi
if [ ! -d "$MAGENTO_ROOT" ]
then
	mkdir -p $MAGENTO_ROOT
fi

cd /var/www/html
if [ ! -e "$MAGENTO_ROOT/index.php" ]
then
  echo "Patching magerun configuration..."
  substitute-env-vars.sh /etc /etc/n98-magerun.yaml.tmpl

  echo "Installing Magento..."
  composer update

  echo "Preparing Magento configuration..."
  substitute-env-vars.sh /etc /etc/local.xml.tmpl
  substitute-env-vars.sh /etc /etc/fpc.xml.tmpl
  cp -v /etc/local.xml /var/www/html/web/app/etc/local.xml
  cp -v /etc/fpc.xml /var/www/html/web/app/etc/fpc.xml

  echo "Installing sample data: Media..."
  curl -s -L https://raw.githubusercontent.com/Vinai/compressed-magento-sample-data/1.9.1.0/compressed-no-mp3-magento-sample-data-1.9.1.0.tgz | tar xz -C /tmp
  cp -av /tmp/magento-sample-data-*/* $MAGENTO_ROOT
  rm -rf /tmp/magento-sample-data-*

  echo "Installing sample data: Database..."
  magerun --skip-root-check --root-dir="$MAGENTO_ROOT" db:create
  magerun --skip-root-check --root-dir="$MAGENTO_ROOT" db:import "$MAGENTO_ROOT/*.sql"
  rm "$MAGENTO_ROOT/*.sql"
  magerun --skip-root-check --root-dir="$MAGENTO_ROOT" cache:clean
  magerun --skip-root-check --root-dir="$MAGENTO_ROOT" index:reindex:all

  echo "Installing sample data: Administrator..."
  magerun --skip-root-check \
          --root-dir="$MAGENTO_ROOT" \
      		admin:user:create \
        		"${ADMIN_USERNAME}" "${ADMIN_EMAIL}" "${ADMIN_PASSWORD}" \
        		"${ADMIN_FIRSTNAME}" "${ADMIN_LASTNAME}" "Administrators"

  echo "Enable fullpage cache..."
  magerun --skip-root-check --root-dir="$MAGENTO_ROOT" cache:enable fpc
else
  echo "Updating Magento"
  cd /var/www/html
  composer update
fi

echo "Fixing filesystem permissions..."
chmod -R go+rw $MAGENTO_ROOT

echo "= - = - = - = - = - = - = - = - = - = - = - = - = - = - ="
echo "Frontend: http://$DOMAIN/ / Backend: http://$DOMAIN/admin"
echo " - Username: ${ADMIN_USERNAME}"
echo " - Password: ${ADMIN_PASSWORD}"

while :
do
	sleep 1
done
exit 0

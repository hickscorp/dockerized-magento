#!/bin/sh

SERVER="http://dockerized-magento.local"
CONSUMER_KEY=a177218da8fa124f918db9a6ec101562
CONSUMER_SECRET=6b96bbbf552551ae2562d5bb60bc411f

oauth --verbose \
      --query-string \
      --consumer-key $CONSUMER_KEY \
      --consumer-secret $CONSUMER_SECRET \
      --access-token-url $SERVER/oauth/token \
      --authorize-url $SERVER/admin/oauth_authorize \
      --request-token-url $SERVER/oauth/initiate \
      --header \
      authorize

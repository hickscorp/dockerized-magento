#!/bin/sh

SERVER=$1
CONSUMER_KEY=$2
CONSUMER_SECRET=$3

oauth --verbose \
      --query-string \
      --consumer-key $CONSUMER_KEY \
      --consumer-secret $CONSUMER_SECRET \
      --access-token-url $SERVER/oauth/token \
      --authorize-url $SERVER/admin/oauth_authorize \
      --request-token-url $SERVER/oauth/initiate \
      --header \
      authorize

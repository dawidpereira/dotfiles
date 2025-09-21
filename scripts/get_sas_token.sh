#!/bin/bash

get_sas_token() {
  local eventhub_uri="$1"
  local key_name="$2"
  local key="$3"
  local expiry="${4:-86400}" # default: 60*60*24 = 86400 seconds

  local encoded_uri
  encoded_uri=$(printf '%s' "$eventhub_uri" | jq -s -R -r @uri)

  local ttl
  ttl=$(($(date +%s) + expiry))

  local utf8_signature
  utf8_signature="${encoded_uri}\n${ttl}"

  local hash
  hash=$(printf '%b' "$utf8_signature" | openssl sha256 -hmac "$key" -binary | base64)

  local encoded_hash
  encoded_hash=$(printf '%s' "$hash" | jq -s -R -r @uri)

  echo "SharedAccessSignature sr=${encoded_uri}&sig=${encoded_hash}&se=${ttl}&skn=${key_name}"
}
get_sas_token "$@"

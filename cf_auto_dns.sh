#!/bin/bash

echo "Cloudflare DNS Auto Configuration"
echo "----------------------------------"

read -p "Enter your domain (example: BetterhavemyMonet.com): " ZONE_NAME
read -s -p "Enter your Cloudflare API Token: " API_TOKEN
echo ""

PUBLIC_IP=$(curl -s https://ipv4.icanhazip.com | tr -d "\n")

if [ -z "$PUBLIC_IP" ]; then
    echo "Could not detect public IP."
    exit 1
fi

echo "Detected Public IP: $PUBLIC_IP"

ZONE_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$ZONE_NAME" \
-H "Authorization: Bearer $API_TOKEN" \
-H "Content-Type: application/json" | jq -r ".result[0].id")

if [ "$ZONE_ID" == "null" ] || [ -z "$ZONE_ID" ]; then
    echo "Could not retrieve Zone ID. Check domain or token permissions."
    exit 1
fi

echo "Zone ID found."

create_or_update_record () {
  NAME=$1
  TYPE="A"
  CONTENT=$PUBLIC_IP

  EXISTING=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?type=$TYPE&name=$NAME.$ZONE_NAME" \
  -H "Authorization: Bearer $API_TOKEN" \
  -H "Content-Type: application/json" | jq -r ".result[0].id")

  if [ "$EXISTING" != "null" ] && [ -n "$EXISTING" ]; then
      curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$EXISTING" \
      -H "Authorization: Bearer $API_TOKEN" \
      -H "Content-Type: application/json" \
      --data "{\"type\":\"$TYPE\",\"name\":\"$NAME.$ZONE_NAME\",\"content\":\"$CONTENT\",\"ttl\":1,\"proxied\":true}"
      echo "Updated $NAME.$ZONE_NAME"
  else
      curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
      -H "Authorization: Bearer $API_TOKEN" \
      -H "Content-Type: application/json" \
      --data "{\"type\":\"$TYPE\",\"name\":\"$NAME.$ZONE_NAME\",\"content\":\"$CONTENT\",\"ttl\":1,\"proxied\":true}"
      echo "Created $NAME.$ZONE_NAME"
  fi
}

create_or_update_record "$ZONE_NAME"
create_or_update_record "www"

echo "Done. DNS set to Proxied + Auto TTL."

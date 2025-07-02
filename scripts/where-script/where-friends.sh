#!/bin/bash

set -eo pipefail

if [ $# -eq 0 ];then 
	echo "Usage: $0 <login>"
	exit 1
fi

bash "${TOSCRIPT}"api_gen.sh
login="$1"

abspath=${TOSCRIPT}.json
echo "Seeking user \"$login\"..."

token=$(jq -r '.access_token' "$abspath"/token.json)
curl -s -H "Authorization: Bearer $token" https://api.intra.42.fr/v2/users/"$login" >"$abspath"/user.json

if jq -e -r '.location' "$abspath"/user.json >/dev/null; then
	jq -r '.location' "$abspath"/user.json
else
	echo "Error: no location found for \"$login\""
fi

rm -f "$abspath"/user.json

#! /bin/bash

bash "${TOSCRIPT}"/api_gen.sh

abspath="${TOSCRIPT}.json"
logs="${TOSCRIPT}.log"

token=$(jq -r '.access_token' "$abspath"/token.json)

if [ ! -f "$abspath"/july.json ]; then
	curl -g -H "Authorization: Bearer $token" \
		"https://api.intra.42.fr/v2/users?filter[primary_campus_id]=9\
	&filter[pool_year]=2025&filter[kind]=student&page[size]=100" \
		>"$abspath"/july.json
fi

jq -r --sort-keys '.[] | "\(.first_name)\t\(.last_name)\t\(.login)\t\(.url)"' "$abspath"/july.json |
	column -t -s $'\t' |
	sed 's|api.intra.42.fr/v2/|profile.intra.42.fr/|g' \
		>"$logs"/july.log

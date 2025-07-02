#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Usage: $0 <login>"
	exit 1
fi

bash "${TOSCRIPT}"api_gen.sh

login="$1"
abspath="${TOSCRIPT}.json"

token=$(jq -r '.access_token' "$abspath"/token.json)
curl -s -H "Authorization: Bearer $token" https://api.intra.42.fr/v2/users/"$login" \
	>"$abspath"/user.json

if jq -e -r '.login' "$abspath"/user.json >/dev/null; then
	echo -n "Informations for: "
	jq -r '.login' "$abspath"/user.json
else
	echo "Error: no such login"
	exit 1
fi

echo -n "Level: "
if jq -e -r '.cursus_users[] | select(.grade == "Cadet") | .level' "$abspath"/user.json >/dev/null; then
	jq '.cursus_users[] | select(.grade == "Cadet") | .level' "$abspath"/user.json
elif jq -e -r '.cursus_users[] | select(.grade == "Transcender") | .level' "$abspath"/user.json; then
	jq '.cursus_users[] | select(.grade == "Transcender") | .level' "$abspath"/user.json
else
	jq '.cursus_users[] | select(.grade == "Pisciner") | .level' "$abspath"/user.json
fi

echo "Current projects: "
jq -r '.projects_users[] | select(.final_mark == null) | "\(.project.name)\t\(.created_at)"' \
	"$abspath"/user.json |
	while IFS=$'\t' read -r project_name created_at; do
		now=$(date +%s)
		created_epoch=$(date -d "$created_at" +%s)
		seconds_elapsed=$((now - created_epoch))
		days=$((seconds_elapsed / 86400))

		printf '%-15.15s | Since: %d days\n' \
			"$project_name" "$days"
	done

echo -n "Alone in the Dark grade: "
jq '.projects_users[] | select(.project.name == "Alone in the Dark") | .final_mark' \
	"$abspath"/user.json || echo "Alone in the Dark not found"

# rm "$abspath"/user.json >/dev/null 2>&1

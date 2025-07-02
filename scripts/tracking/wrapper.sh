#!/bin/bash

set -eo pipefail

abspath="${TOSCRIPT}tutor-tracking"

while read -r line; do
	bash "$abspath"/ttrack "$line"
	echo
done <"$abspath"/tutors

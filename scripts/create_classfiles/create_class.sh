#!/bin/bash

if ! find "$PWD" -maxdepth 1 -type d -name "headers" | grep -q .; then
	mkdir "$PWD/headers"
	echo "created dir: headers"
else
	echo "dir: headers already exists"
fi

if ! find "$PWD" -maxdepth 1 -type d -name "src" | grep -q .; then
	mkdir "$PWD/src"
	echo "created dir: src"
else
	echo "dir: src already exists"
fi

if [ $# -gt 0 ]; then
	for input in "$@"; do
		if find "$PWD/headers" -type f -name "$input.hpp" | grep -q . || \
		find "$PWD/src" -type f -name "$input.cpp" | grep -q .; then
			echo "Files already exist"
		else
			if [[ $input =~ ^[A-Z] ]]; then
				touch "$PWD/src/$input.cpp" "$PWD/headers/$input.hpp"
				echo "Created src/$input.cpp and headers/$input.hpp"
			else
				echo "Expected first character to be uppercase"
			fi
		fi
	done
else
	echo "Expected one argument"
fi
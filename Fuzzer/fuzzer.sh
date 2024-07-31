#!/bin/bash

if [ $# -ne 2  ]; then
	echo "The script only recieve 2 parameters!!"
	echo "Are the following: <dictionary> <URL>"
	exit
fi

dictionary=$1
url=$2

total_lines=$(wc -l $dictionary | awk '{print $1}')
current_line=0

while read -r line; do

	current_line=$((current_line + 1))
	echo -ne "Progress: $current_line/$total_lines\r"

	response=$(curl -s -o /dev/null -w "%{http_code}" "$url$line/")
	if [ $response -eq 200 ]; then
		echo "Available URL: $url$line/"
	fi

done < $dictionary



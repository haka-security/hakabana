#!/bin/bash

if [[ -n "$1" ]]; then
	res=$(curl -s -XDELETE $1/hakabana)
	if [[ -z $res ]]; then
		echo "check elasticsearch server address"
		exit 0
	fi
	if [ "$res" == '{"acknowledged":true}' ]; then
		echo "hakabana index removed successfully"
	elif [[ "$res" == {\"error\":\"IndexMissingException* ]]; then
		echo "'hakabana' missing index"
	else
		echo "failed to remove hakabana index"
	fi
else
	echo "usage: $0 <http://elasticsearch-server[:port]>"
fi


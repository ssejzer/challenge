#!/bin/bash
#
# This script test the Hello World application and returns exitcode 0 if working properly
#

URL="http://challenge.hitechist.com:32003/"

# Get the HTTP status code
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

if [ "$STATUS" -eq 200 ]; then
  echo "The HelloWorld application is working properly. Status: $STATUS"
  exit 0
else
  echo "The application check failed. Status: $STATUS"
  exit 1
fi



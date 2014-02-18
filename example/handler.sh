#!/bin/bash
# Copied from http://www.serfdom.io/intro/getting-started/event-handlers.html

echo
echo "New event: ${SERF_EVENT}. Data follows..."
while read line; do
    printf "${line}\n"
done

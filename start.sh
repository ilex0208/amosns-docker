#!/bin/bash
if [ ! -f config.yaml ]; then
  cp /tmp/config.yaml /opt/amosns/config.yaml
fi
cat /opt/amosns/config.yaml
node /opt/amosns/node_modules/amosns/bin/amosns --config /opt/amosns/config.yaml

#!/bin/sh

flume-ng agent \
  -c $FLUME_HOME/conf \
  -f $FLUME_HOME/conf/flume.conf \
  -n ${FLUME_AGENT_NAME} \
  -Dflume.root.logger=INFO,console \
  $*

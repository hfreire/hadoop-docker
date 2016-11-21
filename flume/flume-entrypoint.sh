#!/bin/bash

for c in `printenv | perl -sne 'print "$1 " if m/^FLUME_CONF_(.+?)=.*/'`; do
    name=`echo ${c} | perl -pe 's/___/-/g; s/__/_/g; s/_/./g'`
    var="FLUME_CONF_${c}"
    value=${!var}
    echo "Setting FLUME property $name=$value"
    echo $name $value >> $FLUME_HOME/conf/flume.conf
done

exec /entrypoint.sh /flume.sh $@

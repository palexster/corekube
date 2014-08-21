#!/bin/bash

EXPECTEDARGS=2
if [ $# -lt $EXPECTEDARGS ]; then
    echo "Usage: $0 <BRANCH> <NUMBER OF EXPECTED MACHINES>"
    exit 0
fi

DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

BRANCH=$1
OVERLORD_COUNT=$2
MASTER_COUNT=$3
MINION_COUNT=$4

MACHINE_COUNT=$(($OVERLORD_COUNT + $MASTER_COUNT + $MINION_COUNT))

result=`docker build --rm -t setup_kubernetes:$BRANCH $DIR/setup_kubernetes/.`
echo "$result"

echo ""
echo "=========================================================="
echo ""

build_status=`echo $result | grep "Successfully built"`

if [ "$build_status" ] ; then
    docker run setup_kubernetes:$BRANCH --machine_count=$MACHINE_COUNT
fi

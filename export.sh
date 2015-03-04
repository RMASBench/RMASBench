#!/bin/bash -e

SRC="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DST="$1"

# Ensure directories have trailing slashes or rsync may screw up
SRC=$(echo $SRC/ | sed 's#//#/#g')
DST=$(echo $DST/ | sed 's#//#/#g')

# Abort on any error
set -e
function recompile {
    cd BinaryMaxSum
    mvn -DskipTests package
    cd -

    cd jMaxSum
    ant clean jar
    cd -

    cd roborescue
    ant clean oldsims jars
    cd -

    cd BlockadeLoader
    ant clean jar
    cd -

    cd RSLB2
    ant clean jar
    cd -
}

echo "Recompiling everything (this may take a while)..."
recompile >/dev/null

echo "Exporting RSLB2..."
rsync -av --include '/RSLB2' \
    --exclude '*.dist' \
    --include '/RSLB2/boot' --exclude '/RSLB2/boot/logs' --exclude '/RSLB2/boot/results' --exclude '/RSLB2/boot/export' --include '/RSLB2/boot/**' \
    --include '/RSLB2/dist' --include '/RSLB2/dist/**' \
    --include '/RSLB2/supplement' --include '/RSLB2/supplement/**' \
    --include '/RSLB2/scenarios' --include '/RSLB2/scenarios/**' \
    --exclude '*' RSLB2 $DST

echo "Exporting BlockadeLoader..."
rsync -av --include '/BlockadeLoader' \
    --include '/BlockadeLoader/dist' --include '/BlockadeLoader/dist/**' \
    --exclude '*' BlockadeLoader $DST

echo "Exporting roborescue..."
rsync -av --include '/roborescue' \
    --include '/roborescue/lib' --include '/roborescue/lib/**' \
    --include '/roborescue/jars' --include '/roborescue/jars/**' \
    --include '/roborescue/maps' --include '/roborescue/maps/**' \
    --exclude '*' roborescue $DST

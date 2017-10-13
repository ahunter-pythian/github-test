#!/bin/bash
# get-version.sh
#
# @author: Anthony Hunter
error_exit() {
	echo "***************************************"
	echo "***** ERROR  ERROR  ERROR  ERROR  *****"
	echo "***** The previous command failed *****"
	echo "***** ABORTING                    *****"
	echo "***************************************"
	exit 1
}
trap error_exit ERR

if [ ! $# == 0 ]; then
	echo "Usage: $0"
	exit 1;
else
	FILENAME=$(basename "$0")
	COMMAND="${FILENAME%.*}"
fi

ROOT=`pwd`

echo "[${COMMAND}] [`date +%H\:%M\:%S`] Started get version"

if [ ! -d ".git" ]; then
	echo "[${COMMAND}] [`date +%H\:%M\:%S`] The directory ${ROOT} is not a git repository"
	exit 1;
fi

if [ ! -d "dist" ]; then
	echo "[${COMMAND}] [`date +%H\:%M\:%S`] The directory dist is missing"
	exit 1;
fi

if [ ! -f "dist/version.js" ]; then
	echo "[${COMMAND}] [`date +%H\:%M\:%S`] The file dist/version.js is missing"
	exit 1;
fi

CURRENT_VERSION=`awk -F'"' '{print $2}' dist/version.js`
echo "[${COMMAND}] [`date +%H\:%M\:%S`] The current version is ${CURRENT_VERSION}"
echo ${CURRENT_VERSION}

exit 0;

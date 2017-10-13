#!/bin/bash
# create-version.sh
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

echo "[${COMMAND}] [`date +%H\:%M\:%S`] Started version creation"

if [ ! -d ".git" ]; then
	echo "[${COMMAND}] [`date +%H\:%M\:%S`] The directory ${ROOT} is not a git repository"
	exit 1;
fi

if [ ! -d "dist" ]; then
	echo "[${COMMAND}] [`date +%H\:%M\:%S`] Create dist directory"
	mkdir dist
fi

echo "[${COMMAND}] [`date +%H\:%M\:%S`] Change directory into the dist directory"
cd dist

echo "[${COMMAND}] [`date +%H\:%M\:%S`] Patch the version string into version.js"
CURRENT_TIMESTAMP=`date +%0Y%0m%0d-%0H%0M%Z`
CURRENT_COMMIT=`git rev-parse --short HEAD`
if [ -z "${BRANCH_NAME}" ]; then
	BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`
fi
CURRENT_VERSION="${CURRENT_COMMIT}-${BRANCH_NAME}-${CURRENT_TIMESTAMP}"
echo "[${COMMAND}] [`date +%H\:%M\:%S`] The current version is ${CURRENT_VERSION}"
echo "exports.version = \"${CURRENT_VERSION}\"" > version.js

echo "[${COMMAND}] [`date +%H\:%M\:%S`] Completed version creation"
exit 0;

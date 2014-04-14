#!/usr/bin/env bash
#
# Script to initialize repo
# - install required node packages
# - install git hooks

node=`which node 2>&1`

if [ $? -ne 0 ]; then
	echo "Please install NodeJS."
	echo "http://nodejs.org/"
	exit 1
fi

echo "Installing required npm packages..."
npm install

gulp=`which gulp 2>&1`
if [ $? -ne 0 ]; then
	echo "Installing gulp..."
	npm install -g gulp
fi

echo "Installing git hooks..."
ln -sf ../../validate-commit-msg.js .git/hooks/commit-msg
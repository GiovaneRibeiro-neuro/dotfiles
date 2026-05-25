#!/bin/bash

GIT_REPO=$1

cd $GIT_REPO

# git pull
/usr/bin/git pull

# stage all changes
/usr/bin/git add --all

# commit 
/usr/bin/git commit -m "sync changes"

# push to origin
/usr/bin/git push origin master

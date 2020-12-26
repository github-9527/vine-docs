#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo -t book 

vine=$GOPATH/src/github.com/lack-io/vine
if [[ -e "$vine" ]];then
    mv public $vine/docs
    echo "update docs to github.com/lack-io/vine"
fi

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push -u origin main
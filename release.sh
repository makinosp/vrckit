#!/bin/zsh

if [ $# != 1 ]; then
    echo "args count error!"
    exit 1
fi

git tag ${1}
git push origin ${1}
gh release create ${1} -t ${1} --generate-notes

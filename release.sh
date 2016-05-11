#!/bin/bash
# This is the automated release script

# bump the version
echo "npm version $1"
npm version $1
git push
git push --tags

# start from a clean state
rm -rf docs/ out/
mkdir out

# build the docs
npm run make-docs
VERSION=`ls docs/github-api`

# switch to gh-pages and add the docs
mv docs/github-api/* out/
rm -rf docs/

git checkout gh-pages
mv out/* docs/
echo $VERSION >> _data/versions.csv
git co -am "adding docs for v$VERSION"
git push

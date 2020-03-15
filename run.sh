#!/bin/bash

BRANCH="$1"

DOTTY_MAJOR_VERSION=`wget -q -O - https://dotty.epfl.ch/versions/latest-nightly-base`
DOTTY_VERSION=`wget -q -O - https://repo1.maven.org/maven2/ch/epfl/lamp/dotty_${DOTTY_MAJOR_VERSION}/maven-metadata.xml | grep "<version>" | /usr/bin/tail -1 | cut -d">" -f2 | cut -d"<" -f1`

echo "Branch: $BRANCH"
echo "Dotty version: $DOTTY_VERSION"

rm -rf shapeless/ && \
git clone https://github.com/milessabin/shapeless.git && \
cd shapeless && \
git checkout shapeless-3 && \
sbt ++$DOTTY_VERSION "clean ; compile ; test:compile ; test"

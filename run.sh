#!/bin/bash

SHAPELESS_BRANCH="$1"

DOTTY_MAJOR_VERSION=`wget -q -O - https://dotty.epfl.ch/versions/latest-nightly-base`
DOTTY_VERSION=`wget -q -O - https://repo1.maven.org/maven2/org/scala-lang/scala3-compiler_${DOTTY_MAJOR_VERSION}/maven-metadata.xml | grep "<version>" | /usr/bin/tail -1 | cut -d">" -f2 | cut -d"<" -f1`

echo "Dotty version: $DOTTY_VERSION"
echo "shapeless branch: $SHAPELESS_BRANCH"

case $SHAPELESS_BRANCH in
  shapeless-3)
    TESTS="test"
    ;;
  *)
    echo "Unknown shapeless branch $SHAPELESS_BRANCH"
    exit 1
esac

echo "Tests:" $TESTS

rm -rf shapeless/ && \
git clone https://github.com/milessabin/shapeless.git && \
cd shapeless && \
git checkout $SHAPELESS_BRANCH && \
sbt ++$DOTTY_VERSION! $TESTS

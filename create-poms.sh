#!/bin/bash

if [ ! -e ./version.txt ] ; then
	echo "Version.txt does not exist"
	exit 1
fi

VERSION=`cat ./version.txt`

if [ -z "$VERSION" ] ; then
	echo "Version.txt is empty"
	exit 2
fi

echo "Creating poms as version $VERSION"

for DIR in `find . -name "pom-template.xml" -exec dirname {} \;` ; do
	echo "Creating pom.xml in $DIR"
	pushd $DIR >/dev/null
	sed -e "s/\${dejalu-version}/$VERSION/" pom-template.xml >pom.xml
	popd >/dev/null
done


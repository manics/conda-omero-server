#!/bin/bash

set -eux
OMERODIR="${PREFIX}/opt/omero/server/OMERO.server"

# Use the decoupled omero-py
rm -rf lib/python bin/

mkdir -p "${OMERODIR}"
mv * "${OMERODIR}"

# Empty directories aren't packaged
echo "$PKG_NAME $PKG_VERSION $PKG_BUILDNUM" > "${OMERODIR}/etc/grid/.conda-build"

cp $RECIPE_DIR/omero-server $PREFIX/bin/
chmod +x $PREFIX/bin/omero-server

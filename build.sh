#!/bin/bash

set -eux
OMERODIR="${PREFIX}/opt/omero/server/OMERO.server"
CONFIGDIR="${PREFIX}/opt/omero/server/config"

mkdir -p "${OMERODIR}"
mv * "${OMERODIR}"

# Symlink duplicate jars
pushd "${OMERODIR}/lib"
for f in client/*; do
    if [ -f "server/${f#*/}" ]; then
        ln -sf "../server/${f#*/}" "./client/${f#*/}"
    fi
done
popd

mkdir -p "$PREFIX/bin" "${OMERODIR}/etc/grid" "${CONFIGDIR}"

# Empty directories aren't packaged
echo "$PKG_NAME $PKG_VERSION $PKG_BUILDNUM" > "${OMERODIR}/etc/grid/.conda-build"
echo "$PKG_NAME $PKG_VERSION $PKG_BUILDNUM" > "${CONFIGDIR}/.conda-build"

cp $RECIPE_DIR/omero-server $PREFIX/bin/
chmod +x $PREFIX/bin/omero-server

#!/bin/bash

installdir="/path/to/project/root/_install" # FIXME
name="${0##*/}"

export LD_LIBRARY_PATH="$installdir/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
export DYLD_LIBRARY_PATH="$installdir/lib${DYLD_LIBRARY_PATH:+:$DYLD_LIBRARY_PATH}" # macOS
export PATH="$installdir/bin:$PATH"
exec "$installdir/bin/$name" "$@"

#!/bin/bash
installdir="/path/to/project/root/_install" # FIXME
export LD_LIBRARY_PATH="$installdir/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
export PATH="$installdir/bin:$PATH"
exec "$installdir/bin/command-name" "$@" # FIXME

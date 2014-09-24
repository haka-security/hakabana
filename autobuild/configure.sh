#! /bin/bash
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

source autobuild/vars.sh
source autobuild/includes.sh

### Cleanup
_run rm -rf "$MAKEDIR"

### Configure
_run mkdir -p "$MAKEDIR"
cd "$MAKEDIR"
_run cmake -DCMAKE_INSTALL_PREFIX=/usr "$ROOT"

### Success
exit 0

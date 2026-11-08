#!/bin/bash
# Node 22 via nvm, needed for the npm entries in the Brewfile.
set -euo pipefail
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"
nvm ls 22 >/dev/null 2>&1 || nvm install 22
nvm alias default 22 >/dev/null

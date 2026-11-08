#!/bin/bash
# Node 24 (LTS) via nvm, needed for the npm entries in the Brewfile.
set -euo pipefail
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"
nvm ls 24 >/dev/null 2>&1 || nvm install 24
nvm alias default 24 >/dev/null

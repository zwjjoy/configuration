#!/bin/bash
# Tools that aren't in the Brewfile, plus hook files their installers own.
set -euo pipefail
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.local/bin:$PATH"

command -v claude >/dev/null || curl -fsSL https://claude.ai/install.sh | bash
command -v herdr >/dev/null || curl -fsSL https://herdr.dev/install.sh | sh

# herdr state hooks (files are owned by herdr, so not tracked here)
status=$(herdr integration status)
for agent in claude pi; do
  if grep -q "^$agent: not installed" <<<"$status"; then
    herdr integration install "$agent"
  fi
done

# rtk command rewriting for pi (claude side is in settings.json + RTK.md)
[ -f "$HOME/.pi/agent/extensions/rtk.ts" ] || rtk init -g --agent pi --no-patch

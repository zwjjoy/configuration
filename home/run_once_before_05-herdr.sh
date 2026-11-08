#!/bin/bash
# herdr + its agent hooks. Runs before files are written: `herdr integration
# install claude` edits ~/.claude/settings.json, and the tracked version should win.
set -euo pipefail
export PATH="$HOME/.local/bin:$PATH"

command -v herdr >/dev/null || curl -fsSL https://herdr.dev/install.sh | sh

status=$(herdr integration status)
for agent in claude pi; do
  if grep -q "^$agent: not installed" <<<"$status"; then
    herdr integration install "$agent"
  fi
done

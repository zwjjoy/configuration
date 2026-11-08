#!/bin/bash
# Agent tools that aren't in the Brewfile. Runs after brew bundle (needs rtk).
set -euo pipefail
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.local/bin:$PATH"

command -v claude >/dev/null || curl -fsSL https://claude.ai/install.sh | bash

# rtk command rewriting for pi (claude side is in settings.json + RTK.md)
[ -f "$HOME/.pi/agent/extensions/rtk.ts" ] || rtk init -g --agent pi --no-patch

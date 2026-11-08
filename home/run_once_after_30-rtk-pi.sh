#!/bin/bash
# rtk command rewriting for pi. Runs after brew bundle, which installs rtk.
# (The Claude side is already in settings.json + RTK.md.)
set -euo pipefail
eval "$(/opt/homebrew/bin/brew shellenv)"
[ -f "$HOME/.pi/agent/extensions/rtk.ts" ] || rtk init -g --agent pi --no-patch

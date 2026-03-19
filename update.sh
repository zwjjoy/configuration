#!/usr/bin/env bash

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

FILES=(
  .zshrc
  .zprofile
  .p10k.zsh
  .tmux.conf
  .vimrc
  .gitconfig
)

for file in "${FILES[@]}"; do
  src="$HOME/$file"
  dest="$REPO_DIR/$file"
  if [[ -f "$src" ]]; then
    cp "$src" "$dest"
    echo "updated: $file"
  else
    echo "skipped: $file (not found in $HOME)"
  fi
done

# Claude settings
CLAUDE_SETTINGS="$HOME/.claude/settings.json"
if [[ -f "$CLAUDE_SETTINGS" ]]; then
  mkdir -p "$REPO_DIR/.claude"
  cp "$CLAUDE_SETTINGS" "$REPO_DIR/.claude/settings.json"
  echo "updated: .claude/settings.json"
else
  echo "skipped: .claude/settings.json (not found)"
fi

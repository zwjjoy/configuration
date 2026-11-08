# configuration

Dotfiles managed by [chezmoi](https://chezmoi.io). Managed files live in `home/` (see `.chezmoiroot`).

## New machine

```sh
# install Homebrew first: https://brew.sh
brew install chezmoi
chezmoi init --apply zwjjoy/configuration --source ~/Projects/configuration
```

`apply` also runs `brew bundle` on the `Brewfile` (taps, formulae, casks, npm/go/uv tools).

Then:

- Put secrets back in `~/.secrets/` (not in this repo):
  - `env.zsh`: shell exports, sourced by `.zprofile`
  - `openrouter-api-key.txt`: read into `~/.claude/settings.json` when applying
- Install the tools that don't come from Homebrew: herdr, Claude Code, Codex
- Run `rtk init -g` and `rtk init -g --agent pi` for the RTK hooks

## Daily use

| Task | Command |
|---|---|
| Edited a file in `~`, save it to the repo | `chezmoi re-add` |
| Start tracking a new file | `chezmoi add ~/.config/foo/config.toml` |
| See what would change in `~` | `chezmoi diff` |
| Pull repo changes into `~` | `chezmoi update` |
| Edit a template (e.g. Claude settings) | `chezmoi edit ~/.claude/settings.json` |
| Installed/removed a brew package | `brew bundle dump --force --file=~/Projects/configuration/Brewfile` |

`re-add` skips templates (`*.tmpl`). For those, edit with `chezmoi edit` or `chezmoi merge`.

Commit and push from `~/Projects/configuration` like any repo.

## Agent instructions and skills

One source, linked into each agent:

```
~/.agents/AGENTS.md          shared rules (the only file to edit)
~/.codex/AGENTS.md           -> ~/.agents/AGENTS.md
~/.pi/agent/AGENTS.md        -> ~/.agents/AGENTS.md
~/.claude/CLAUDE.md          imports ~/.agents/AGENTS.md + Claude-only RTK.md
~/.pi/agent/APPEND_SYSTEM.md -> ~/.claude/RTK.md

~/.agents/skills/<name>      skills (Codex and pi read this directly)
~/.claude/skills/<name>      -> ~/.agents/skills/<name>
```

New skill: add it under `~/.agents/skills/`, then `ln -s ../../.agents/skills/<name> ~/.claude/skills/<name>` and `chezmoi add` both.

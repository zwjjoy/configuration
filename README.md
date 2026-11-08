# configuration

Dotfiles managed by [chezmoi](https://chezmoi.io). Managed files live in `home/` (see `.chezmoiroot`).

## New machine

1. Install [Homebrew](https://brew.sh), then `brew install chezmoi`.
2. Copy `~/.secrets/` from another machine (AirDrop, USB). It is not in this repo:
   - `env.zsh`: shell exports, sourced by `.zprofile`
   - `openrouter-api-key.txt`: read into `~/.claude/settings.json` when applying
3. If an old clone of this repo exists, move it aside: `mv ~/Projects/configuration ~/Projects/configuration.old`
4. Clone, review, apply:
   ```sh
   chezmoi init zwjjoy/configuration --source ~/Projects/configuration
   chezmoi diff     # what will be overwritten in ~
   chezmoi apply
   ```
   `apply` also clones powerlevel10k and nvm, installs Node 22, runs `brew bundle`,
   installs Claude Code and herdr if missing, and sets up the herdr and rtk hooks.
5. If `~/AGENTS.md` exists (old layout), merge anything you want into `~/.agents/AGENTS.md`
   (`diff ~/AGENTS.md ~/.agents/AGENTS.md`), then `rm ~/AGENTS.md`. Otherwise pi loads it twice.
6. Log in: `gh auth login`, `claude`, `pi` (`/login`), Codex app.
7. Open a new terminal.

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

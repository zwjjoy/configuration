# configuration

Dotfiles managed by [chezmoi](https://chezmoi.io). Managed files live in `home/` (see `.chezmoiroot`).

## New machine

```sh
brew install chezmoi
chezmoi init --apply zwjjoy/configuration --source ~/Projects/configuration
```

Then put secrets back in `~/.secrets/` (not in this repo):

- `env.zsh`: shell exports, sourced by `.zprofile`
- `openrouter-api-key.txt`: read into `~/.claude/settings.json` when applying

## Daily use

| Task | Command |
|---|---|
| Edited a file in `~`, save it to the repo | `chezmoi re-add` |
| Start tracking a new file | `chezmoi add ~/.config/foo/config.toml` |
| See what would change in `~` | `chezmoi diff` |
| Pull repo changes into `~` | `chezmoi update` |
| Edit a template (e.g. Claude settings) | `chezmoi edit ~/.claude/settings.json` |

`re-add` skips templates (`*.tmpl`). For those, edit with `chezmoi edit` or `chezmoi merge`.

Commit and push from `~/Projects/configuration` like any repo.

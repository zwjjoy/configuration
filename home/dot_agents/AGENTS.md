## First Principle

Start from the original requirements and the essence of the problem, not from conventions or templates.

1. Don't assume I know what i want. When motivation or goals are unclear, stop and discuss.
2. If the goal is clear but the path isn't the shortest, say so directly and suggest a better approach.
3. When encoutering problems, find the root cause - DO NOT patch. Every decision must be able to answer "why".
4. Get to the point. Cut everything that doesn't change the decision. No pleasantry.

## Other Principles

1. Never `git push` a commit on your own unless you are explicitly told so. the maximum should do is `git add` changed files you made and add commit messages.
2. Do not assume documentation to be up to date, refer to code when the information is critical for decision/judgement.
3. Update AGENTS.md if it helps future conversation.
4. No ponytail initials, always make commit message easy to read, humanlike, no emdashes, as if I did it. The commit message should be short and no verbose explaination.

## Dotfiles

- Managed by chezmoi. Source repo: `~/Projects/configuration` (public on GitHub), managed files under `home/`.
- After editing a managed dotfile in `~`, run `chezmoi re-add`. Templates (`*.tmpl`) need `chezmoi edit` instead.
- Never put secrets in managed files. Put them in `~/.secrets/` and source or template them in.
- Agent instructions: this file (`~/.agents/AGENTS.md`) is the single source. `~/.codex/AGENTS.md` and `~/.pi/agent/AGENTS.md` symlink to it; `~/.claude/CLAUDE.md` imports it with `@`. Keep tool-specific syntax (like `@imports`) out of this file.
- Skills live in `~/.agents/skills/`. Claude needs a symlink per skill in `~/.claude/skills/`.

## Notes (Obsidian vault)

- My notes live at `~/Notes` (plain markdown, Obsidian vault). Read/search/write there directly when I mention my notes.
- It's an LLM Wiki (Karpathy pattern). Before touching anything in `~/Notes`, read `~/Notes/AGENTS.md`: it defines ownership (`raw/` immutable, `wiki/` agent-owned, my own folders read-only) and the ingest/query/lint workflows.
- Synced to phones via Remotely Save + Cloudflare R2. Images/attachments go in `~/Notes/attachments/`, link with `![[file]]`.
- It's also a private git repo (github.com/zwjjoy/notes). Commit before bulk edits so changes can be reverted.
- Never touch `.obsidian/plugins/remotely-save/data.json` (contains secrets). Credentials live in `~/.secrets/`, never in the vault.

# /ps-factory init

Set up a project for the factory once. Ask the owner each value marked *ask*; take the rest from the repo.

1. **Project Policy.** Copy [templates/policy.md](../templates/policy.md) to `<repo>/.ps-factory/policy.md` and fill it in: Target Branch (*ask*: the branch the project develops on, which may be `main`, `dev`, `develop` or another; offer the remote's default branch and any long-lived development branches you find, recommend the one recent pull requests target), who merges Slices and Story pull requests (*ask*; default `owner`), the open-Story limit (default 3), the models per role (keep the defaults unless the owner wants otherwise), and the checks (read them from the project's scripts, CI config and `CLAUDE.md` / `AGENTS.md`, then confirm with the owner). Commit it through the project's normal branch rules.
2. **State folder.** Create `~/.ps-factory/<project>/stories/`, a `ledger.md` with the header row from the Orchestrator role file, and empty `decisions.md` and `archive.md`.
3. **Claude Code settings** (once per machine). Tell the owner what [scripts/install-settings.sh](../scripts/install-settings.sh) changes, then run it with their OK: it adds the SessionStart hook that restores state after `compact|clear|resume`. It is idempotent and keeps a backup. Ask the owner to open `/hooks` once or restart so the running session picks it up.
4. **Orca** (skip under Herdr):
   - `orca repo list --json`: if the repo is missing, `orca repo add --path <repo> --json`.
   - New workspaces must be ready to build and test. If the repo has no setup hook (dependency install, env file copy, local services), propose one in the repo's Orca config and confirm it with the owner before writing it.
5. Tell the owner the factory is ready and how to start: open a chat in the project's main workspace and run `/ps-factory`.

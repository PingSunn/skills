# Runtime: Herdr

Invoke the `herdr` skill first and keep its rules; `herdr --help` and the command groups (`herdr agent`, `herdr pane`, `herdr worktree`) are the authority on syntax. Herdr has no mailbox: a Report is a prompt submitted to the receiving agent by name.

## Pane layout

The first agent you start goes in a split to the right of your pane; every further agent stacks downward in that right-hand column. Keep focus in your own pane (`--no-focus`).

## Starting roles

1. Create the workspace the role needs: a new git worktree for a Lead (based on the Target Branch) or a Dev (based on `feat/<story>`); the Story QA shares the Lead's. A Slice QA needs no pane: the Lead spawns it as a sub-agent.
2. Split a pane for it with `--cwd <that worktree>` and `--no-focus`.
3. `herdr agent start <name> --kind claude --pane <pane id> -- --model <model id>`. Names: `lead-<story>`, `qa-<story>` (Story QA only), `dev-<story>-<slice>`.
4. Submit the brief: `herdr agent prompt <name> "<brief>"`. Its first line is `ps-factory role: <Role>`, its second `Invoke the ps-factory skill and follow your role file.`, its third `Write English everywhere, including your terminal replies.`

A role's address is its agent name.

## Sending Reports

- Any role to any role: `herdr agent prompt <receiver> "<report>"`, starting with your own agent name so the receiver can answer.
- To wait for an answer: `herdr agent wait <receiver> --timeout <ms>` after prompting, or end your turn and let the receiver prompt you back.
- Check whether a role is still alive: `herdr agent list`.

## Releasing and refreshing

- *release worker*: close the agent's pane once it has reported (see `herdr pane` for the close command).
- *resume Lead*: release the old Lead, then start a new Lead in the Story worktree with a brief that says to resume from the Story Notes. *resume Run* has no Herdr equivalent: the new Lead re-reads the agent names from the Story Notes.

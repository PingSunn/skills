# Runtime: Orca

Load Orca's own guide once per session (`orca skills get orchestration`) and keep its rules: never poll or watch inboxes (Orca wakes you), never type into another agent's terminal, write message bodies to a file and pass `--body-file` / `--spec-file`, and never retry a failed `send` or `worker-start` on your own. Put `--environment local` on every `worker-start` and `worker-list`.

## Starting and replacing roles

| Action | Command |
| --- | --- |
| *start Lead* (Orchestrator) | `orca orchestration worker-start --environment local --worktree new-child --name <story> --base-branch <Target Branch> --agent claude --model <Lead model> --keep-open --task-title "<story>" --spec-file <brief>` |
| *resume Lead* (Orchestrator, for a refresh) | `orca orchestration worker-start --environment local --worktree branch:feat/<story> --agent claude --model <Lead model> --keep-open --task-title "<story> (resumed)" --spec-file <brief>` |
| *start Dev* (Lead) | `orca orchestration worker-start --environment local --worktree new-child --name <story>-<slice> --base-branch feat/<story> --agent claude --model <Dev model> --task-title "<story>/<slice> dev" --spec-file <brief>` |
| *start Story QA* (Lead) | `orca orchestration worker-start --environment local --worktree current --agent claude --model <Story QA model> --task-title "<story> story qa" --spec-file <brief>` |
| *list workers* | `orca orchestration worker-list --environment local --json` |
| *release worker* | `orca orchestration worker-release --dispatch <id>` |
| *resume Run* (Lead after a reset) | `orca orchestration run-use <run_id>` with the Run id from the Story Notes |

Every Story workspace is a child of the project's main checkout, so the owner sees each Story under it in Orca's sidebar. `new-child` does this on its own. If the Orchestrator cuts the Story Branch itself and creates the workspace by hand, it passes the parent explicitly: `orca worktree create --environment local --repo path:<main checkout> --name <story> --base-branch origin/feat/<story> --branch feat/<story> --setup skip --parent-worktree path:<main checkout> --json`, then starts the Lead with `--worktree branch:feat/<story>`. Never pass `--no-parent` for a Story. A workspace already created without a parent is fixed with `orca worktree set --worktree branch:feat/<story> --parent-worktree path:<main checkout> --json`.

`<… model>` is the role's model from the Project Policy's `## Models` section, else the default in SKILL.md.

Every brief's first line is `ps-factory role: <Role>`, its second `Invoke the ps-factory skill and follow your role file.`, its third `Write English everywhere, including your terminal replies.` A worker's address is `dispatch:<dispatch_id>` from the start receipt; a Dev's workspace selector is the `id:` the receipt names. The first `worker-start` binds a Run to the caller: the Orchestrator's Run holds the Leads, each Lead's own Run holds its Devs and the Story QA. A Slice QA is not started through Orca: the Lead spawns it with its agent tool, passing `<Slice QA model>` as the model.

Lifetimes: Leads use `--keep-open` because Orca auto-releases a worker about two minutes after its `worker_done`, and a Lead must survive between tasks. The Story QA, started in the Lead's workspace, closes on its own after its `worker_done`. A Dev in a new child workspace stays open until released: the Lead releases it once its Slice is merged.

## Sending Reports

| From → to | Command |
| --- | --- |
| Orchestrator → Lead, Lead → Dev/Story QA, Dev → Lead | `orca orchestration send --to dispatch:<id> --type <dispatch\|question\|status> --subject "<report type>: <story/slice>" --body-file <file>` |
| Worker → its coordinator, answer needed (`needs-decision`, `awaiting-merge`, `blocked`, a Dev's question) | `orca orchestration ask --question "<summary>"`, then end your turn; the answer wakes you |
| Worker → its coordinator, no answer needed (Lead `refresh-ready`) | `orca orchestration send --type status --subject "..." --body-file <file>` (no `--to`: it goes to your coordinator) |
| Worker finishing its task (Dev `slice-done`, Story QA verdict, Lead `story-ready`) | the `worker_done` your dispatch preamble describes, with the Report as its body |
| Answering a message | `orca orchestration reply --id <message_id> --body-file <file>` |

A message sent to a finished worker reopens it as a follow-up task, so routing new work to a settled Lead needs nothing special.

## Workspace housekeeping

- Status card: `orca worktree set --worktree active --workspace-status <todo|in-progress|in-review|completed> --comment "<one line>" --json`. Leads update it at each Slice merge and at `story-ready`.
- Link pull requests: `orca reference add <PR URL> --worktree active --json`.
- Ask the owner's attention on a workspace: `orca worktree set --worktree active --unread --json`.
- Lost track of mail after a reset: `orca orchestration inbox --terminal run:<run_id> --limit 50 --full` (coordinator) or `--terminal dispatch:<id>` (worker).

# Reports

Every Report starts with one subject line, `<type>: <story>[/<slice>]`, then the fields below. Write it so the receiver can act without asking back: links, commands run with their results, and evidence instead of claims.

## Dev ↔ Lead and QA → Lead

- **`review-request`** (Dev → Lead): Slice pull request URL, workspace path, checks run with results, each acceptance criterion with how it is met. In later rounds: each previous finding number with what changed, or why the Dev disputes it.
- **`verdict`** (QA → Lead, as the sub-agent's result; the Lead forwards a `fail` to the Dev): `pass` or `fail`, round number, numbered findings (severity `blocker` / `should-fix` / `nit`, the criterion broken, evidence: command output, file:line, reproduction). The whole-Story QA sends its `verdict` to the Lead the same way.
- **`slice-done`** (Dev → Lead): Slice pull request URL, final round count, checks with results.
- A Dev's question: what is unclear, the options, the Dev's recommendation.

## Lead → Orchestrator

The Lead reports only at these points, nothing else:

- **`needs-decision`**: the question in plain words, the options, the Lead's recommendation, what is paused meanwhile.
- **`awaiting-merge`**: the pull request URL (Slice or Story), the QA verdict, check status.
- **`story-ready`**: Story pull request URL, Slices with their pull requests, the whole-Story QA verdict, anything the owner should check by hand.
- **`blocked`**: what blocks, what was tried, what would unblock it.
- **`refresh-ready`**: the Story Notes are current and the Lead has stopped; Slices still running, by name.

## Orchestrator → Lead

- **`dispatch`**: new or follow-up work routed to the Story, with its acceptance criteria.
- An answer to a Lead's question, sent as a reply to it.

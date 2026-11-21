# Three-tier roles with direct Dev–QA messaging

The factory runs as Orchestrator → Lead → Dev + QA. Dev and QA message each other directly during a Story's fix loop, report to their Lead, and only the Lead reports to the Orchestrator. A per-Story Lead (on Opus) keeps the Orchestrator's context small and lets several Stories run without the Orchestrator being woken on every Dev–QA round; direct Dev–QA messaging avoids routing each review finding through a middleman.

## Considered options

- **Hub-and-spoke (Orchestrator talks to Dev and QA directly):** rejected; the Orchestrator would be woken on every review round of every Story.
- **Dev as Lead (no third agent per Story):** rejected; no independent party settles a Dev–QA disagreement.
- **Lead on Sonnet:** rejected in favour of Opus so the Lead can judge Dev–QA disputes well.

## Consequences

Orca does not hand sibling workers each other's addresses, so the Lead must send Dev and QA each other's Dispatch IDs after starting them. Orca also does not hold a Lead's `worker_done` until its own workers settle; the Lead must wait for them before reporting.

# Slice QA is a sub-agent of the Lead

A Slice QA is no longer a worker the Lead starts through the runtime. The Lead spawns a fresh QA sub-agent for each review round, with the acceptance criteria, the pull request, the Dev's workspace path and the previous findings, and the sub-agent's verdict is its result. The Dev sends its `review-request` to the Lead, not to a QA, and the Lead forwards a `fail` verdict to the Dev. The whole-Story QA stays a separate agent started through the runtime.

This changes the direct Dev–QA messaging of [ADR 0001](0001-three-tier-roles-with-direct-dev-qa.md). A sub-agent needs no pane or workspace, no address exchange between siblings, and is fresh every round without extra work, so the tree the owner watches shrinks to Orchestrator, Lead, Dev and the Story QA. The Lead is now woken once per round, but it only receives a verdict summary, so its context grows little. The whole-Story QA remains separate because it runs long and is the last gate before the owner, who should be able to watch it.

## Considered options

- **Keep a separate QA agent per Slice:** rejected; every Slice costs a pane, an address exchange and a runtime start for a short, bounded check.
- **Drop the Slice QA and rely on the whole-Story QA:** rejected; the independent per-Slice check catches findings while they are cheap to fix, and the Dev would otherwise grade its own work.
- **Reuse one QA sub-agent across rounds:** rejected; a fresh context each round keeps the check independent of the Dev's earlier arguments.

## Consequences

The Lead's agent tool must be able to run and read the Dev's workspace. A Slice QA has no Run of its own, so it does not appear in the runtime's worker list. If the Lead is refreshed mid-Slice, the Story Notes hold the round and open findings, and a fresh Lead spawns the next QA from them.

# State on disk, clear at checkpoints, refresh Leads

The Orchestrator and Leads treat their context as a cache: they write state to disk before acting (Story Ledger, Decision Log, Story Notes), and a SessionStart hook re-injects that state after any `/clear`, compaction or resume. The owner clears the Orchestrator at checkpoints it announces; auto-compaction stays on only as a safety net. Leads cannot be cleared by another agent under Orca's rules, so the Orchestrator refreshes them instead, replacing a Lead with a fresh one that resumes from its Story Notes, every 3 merged Slices and after `story-ready`. Devs and QAs are per Slice and close when it is done, so they never need either.

## Considered options

- **Compaction only:** rejected; summaries drift and stack on each other, and can contradict the ledger.
- **A prose rule to re-read the ledger after compaction:** rejected; prose triggers get skipped, which is why the hook exists.
- **Refresh Leads after every Slice:** rejected; too many Opus restarts and hand-overs while other Slices are running.
- **One QA for the whole Story:** rejected; its context grows with every Slice.

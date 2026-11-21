# English between agents, owner's language only at the Orchestrator

Context: the owner writes Thai or English, and every message, brief and state file costs tokens each time an agent reads it. Thai text tokenizes far worse than English.

Decision: only the Orchestrator talks to the owner, in the owner's language. All agent-to-agent traffic (Orchestrator → Lead → Dev/QA, Reports, briefs, Story Notes, ledger, decisions, pull requests, commits) is English. The Orchestrator translates in both directions.

Why: the owner-facing edge is the only place where the owner's language matters, and the Orchestrator already owns that edge. Keeping the rest in English saves tokens on every hop and matches the language of code, commits and documentation.

Considered options: owner's language everywhere (rejected: costs tokens at every hop); English everywhere including the owner chat (rejected: the owner wants Thai replies).

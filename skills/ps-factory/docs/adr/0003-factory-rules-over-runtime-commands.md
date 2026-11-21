# Factory rules sit above the agent runtime

The factory's roles, Reports, Fix Loop and branch strategy are the same whichever agent runtime hosts them; only the commands differ. Under Orca the factory uses Orca's orchestration commands and pane rules, and under Herdr it uses Herdr's commands and pane layout. The factory replaces the earlier per-project multi-agent rules (ipd-report's Dev-on-Sonnet/QA-as-subagent memory and merge policy, and the global feature-integration-branch rule), which now live on as a Project Policy and ADR 0002.

## Considered options

- **Orca only:** rejected; the owner also drives agents through Herdr.
- **Keep the old per-project rules alongside the factory:** rejected; two sets of rules for the same work would drift.

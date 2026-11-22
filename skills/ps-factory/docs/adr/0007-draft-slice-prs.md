# 7. Slice pull requests stay draft until QA passes

Several Devs run in parallel and each Fix Loop round pushes again, so a Slice pull request opened ready for review runs the project's full CI (often including e2e) on every push, most of it on code that QA will still send back. Devs now open every Slice pull request as a draft, and the Lead marks it ready only after the Slice QA passes; a CI failure after that goes back into the Fix Loop. When several Slices pass together, the Lead marks them ready one at a time in merge order and rebases the next after each merge, so CI runs once per Slice on the base it lands on. This only saves CI time when the project's workflow skips draft pull requests (for GitHub Actions: `pull_request` types including `ready_for_review`, and jobs guarded by `github.event.pull_request.draft == false`); `/ps-factory init` should check that and offer the change.

## Considered options

- Open ready and accept the CI cost: simplest, but parallel Slices and Fix Loop rounds multiply full CI runs.
- Hold the push until QA passes: QA reads the pull request diff, so the pull request must exist; a draft gives the diff without CI.

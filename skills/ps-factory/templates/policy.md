# ps-factory Project Policy

## Branches

- Target Branch: `<the project's development branch>`

## Merging

- Slice pull requests into the Story Branch are merged by: `owner` <!-- owner | lead -->
- Story pull requests into the Target Branch are merged by: `owner` <!-- owner | orchestrator -->
- A role other than the owner merges only when the pull request's checks pass and the QA passed it.

## Limits

- Open Stories at a time: 3

## Models

Delete a line to keep the skill's default.

- Lead: `claude-opus-5-5`
- Dev: `claude-sonnet-5-5`
- Slice QA: `claude-sonnet-5-5`
- Story QA: `claude-opus-5-5`

## Checks

Commands every Dev runs before a review request, and every QA runs when checking:

- `<lint command>`
- `<test command>`

## Project notes

Anything the roles must know about this project that its `CLAUDE.md` / `AGENTS.md` does not already say.

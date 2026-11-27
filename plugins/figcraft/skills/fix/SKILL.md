---
name: fix
description: Fix the design in FigCraft from open comment threads that start with !fix, then reply with what changed.
disable-model-invocation: true
---

# /figcraft:fix

Work every **todo** thread of the open FigCraft file. Thread states, the tools and the attach check are in [../../reference/threads.md](../../reference/threads.md); read it first.

Done when each todo thread is **fixed** or **waiting**, or when there are none (say so).

## For each todo thread

1. **Anchor.** `get_node` the thread's `anchor` layer (depth 2) and `screenshot` it: this is the before. The anchor and its children are the **scope**. A thread with `anchor: null` is pinned to a point: find the innermost layer under its `x`,`y` inside its `frame` and use that layer, saying so in the reply.
2. **Rules.** Read the project's `DESIGN.md` when the repo root has one, and `variable.list` for the file's tokens. Prefer bound variables over raw values.
3. **Decide.** Load `impeccable` and let it choose the fix. Consult `ui-ux-pro-max` only when the comment is ambiguous or concerns accessibility.
4. **Blast radius.** A fix inside the scope goes ahead. A fix that must change a variable, style or component used outside the scope waits: reply `Ask: <what changes, which layers or pages use it>` and move to the next thread. The owner's "ok" makes it a todo thread again.
5. **Apply** with `set_properties`, `batch` or `variable.set`. Screenshot the anchor again and compare with the comment's words.
6. **Conflict.** A comment that breaks a `DESIGN.md` or brand-kit rule is applied as written, and the reply names the rule.
7. **Reply** `Fixed: <layer>: <old> → <new>` per change, plus any rule warning. Leave the thread open: the owner resolves.

After the last thread, `save_file` once. Report to the owner per thread: fixed, waiting, or skipped, with one line each.
